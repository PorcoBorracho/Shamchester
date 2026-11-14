-- ============================================================
--  Shamchester United · Modelo de datos para Supabase (PostgreSQL)
--  Ejecutar en el SQL Editor de Supabase en este orden.
--  Requiere la extensión pg_cron (Database > Extensions > pg_cron).
-- ============================================================

create extension if not exists pg_cron;

-- ------------------------------------------------------------
--  1. TABLAS
-- ------------------------------------------------------------

-- Temporadas (2026-27, ...)
create table public.temporadas (
                                   id      bigint generated always as identity primary key,
                                   nombre  text not null unique,              -- '2026-27'
                                   inicio  date not null,
                                   fin     date not null,
                                   actual  boolean not null default false,
                                   check (fin > inicio)
);
-- Solo una temporada puede ser la actual
create unique index temporadas_una_actual on public.temporadas (actual) where actual;

-- Jugadores (datos personales, independientes de la temporada)
create table public.jugadores (
                                  id         bigint generated always as identity primary key,
                                  nombre     text not null,
                                  posicion   text not null,                  -- 'Porteiro', 'Defensa', 'Centrocampista', 'Dianteiro'
                                  lesionado  boolean not null default false,
                                  foto       bytea                           -- imagen en binario
);

-- Características de cada jugador (Reflexos, Velocidade...)
create table public.jugador_caracteristicas (
                                                id           bigint generated always as identity primary key,
                                                jugador_id   bigint not null references public.jugadores (id) on delete cascade,
                                                descripcion  text not null,
                                                orden        smallint not null default 0,
                                                unique (jugador_id, descripcion)
);

-- Plantilla: qué jugadores forman parte de cada temporada
-- El dorsal cambia de una temporada a otra, por eso vive aquí.
create table public.plantilla (
                                  temporada_id  bigint not null references public.temporadas (id) on delete cascade,
                                  jugador_id    bigint not null references public.jugadores (id) on delete cascade,
                                  dorsal        smallint not null check (dorsal between 1 and 99),
                                  primary key (temporada_id, jugador_id),
                                  unique (temporada_id, dorsal)               -- dorsal único por temporada
);

-- Rivales
create table public.rivales (
                                id      bigint generated always as identity primary key,
                                nombre  text not null unique,
                                escudo  bytea                               -- imagen en binario
);

-- Partidos
create table public.partidos (
                                 id             bigint generated always as identity primary key,
                                 temporada_id   bigint not null references public.temporadas (id),
                                 jornada        smallint check (jornada > 0),
                                 fecha_hora     timestamptz not null,
                                 rival_id       bigint not null references public.rivales (id),
                                 goles_favor    smallint check (goles_favor >= 0),
                                 goles_contra   smallint check (goles_contra >= 0),
                                 finalizado     boolean not null default false,  -- se pone a true 1 h después de fecha_hora
    -- V / E / D calculado automáticamente
                                 resultado      char(1) generated always as (
                                     case
                                         when goles_favor is null or goles_contra is null then null
                                         when goles_favor > goles_contra then 'V'
                                         when goles_favor = goles_contra then 'E'
                                         else 'D'
                                         end
                                     ) stored,
                                 unique (temporada_id, jornada)
);
create index partidos_fecha on public.partidos (fecha_hora);
create index partidos_pendientes on public.partidos (fecha_hora) where not finalizado;

-- Maestra de información del club (clave / valor)
create table public.club_info (
                                  clave        text primary key,              -- 'contacto.email', 'redes.instagram'...
                                  valor        text not null,
                                  grupo        text not null default 'general', -- contacto, redes, estadio, general
                                  descripcion  text,
                                  actualizado  timestamptz not null default now()
);

-- Suscriptores de la newsletter
create table public.newsletter_suscriptores (
                                                id         bigint generated always as identity primary key,
                                                email      text not null unique check (email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$'),
    creado_en  timestamptz not null default now(),
    baja_en    timestamptz
);

-- ------------------------------------------------------------
--  2. AUTOACTUALIZACIÓN DE partidos.finalizado
-- ------------------------------------------------------------

-- a) Al insertar o cambiar la fecha, se calcula en el momento
create or replace function public.partidos_calcular_finalizado()
returns trigger language plpgsql as $$
begin
    new.finalizado := now() >= new.fecha_hora + interval '1 hour';
return new;
end $$;

create trigger partidos_finalizado
    before insert or update of fecha_hora on public.partidos
    for each row execute function public.partidos_calcular_finalizado();

-- b) Cada 5 minutos se marcan los partidos que ya pasaron su hora + 1 h
select cron.schedule(
               'partidos-finalizar',
               '*/5 * * * *',
               $$update public.partidos
         set finalizado = true
       where not finalizado
         and fecha_hora + interval '1 hour' <= now()$$
       );

-- ------------------------------------------------------------
--  3. VISTAS DE AYUDA
-- ------------------------------------------------------------

-- Próximo partido
create view public.v_proximo_partido as
select p.id, p.jornada, p.fecha_hora, r.nombre as rival, r.escudo
from public.partidos p
         join public.rivales r on r.id = p.rival_id
where not p.finalizado
order by p.fecha_hora
    limit 1;

-- Histórico con resultado
create view public.v_historico as
select p.id, t.nombre as temporada, p.jornada, p.fecha_hora, r.nombre as rival,
       p.goles_favor, p.goles_contra, p.resultado
from public.partidos p
         join public.rivales r    on r.id = p.rival_id
         join public.temporadas t on t.id = p.temporada_id
where p.finalizado
order by p.fecha_hora desc;

-- Plantilla de la temporada actual
create view public.v_plantilla_actual as
select pl.dorsal, j.id as jugador_id, j.nombre, j.posicion, j.lesionado, j.foto
from public.plantilla pl
         join public.jugadores  j on j.id = pl.jugador_id
         join public.temporadas t on t.id = pl.temporada_id and t.actual
order by pl.dorsal;

-- ------------------------------------------------------------
--  4. SEGURIDAD (RLS)
--  Lectura pública con la anon key; escritura solo con service_role.
--  Newsletter: cualquiera puede apuntarse, nadie anónimo puede leer.
-- ------------------------------------------------------------
alter table public.temporadas              enable row level security;
alter table public.jugadores               enable row level security;
alter table public.jugador_caracteristicas enable row level security;
alter table public.plantilla               enable row level security;
alter table public.rivales                 enable row level security;
alter table public.partidos                enable row level security;
alter table public.club_info               enable row level security;
alter table public.newsletter_suscriptores enable row level security;

create policy lectura_publica on public.temporadas              for select using (true);
create policy lectura_publica on public.jugadores               for select using (true);
create policy lectura_publica on public.jugador_caracteristicas for select using (true);
create policy lectura_publica on public.plantilla               for select using (true);
create policy lectura_publica on public.rivales                 for select using (true);
create policy lectura_publica on public.partidos                for select using (true);
create policy lectura_publica on public.club_info               for select using (true);
create policy alta_publica    on public.newsletter_suscriptores for insert with check (true);

-- Las vistas respetan el RLS de quien consulta
alter view public.v_proximo_partido  set (security_invoker = true);
alter view public.v_historico        set (security_invoker = true);
alter view public.v_plantilla_actual set (security_invoker = true);


-- ============================================================
--  5. DATOS DE EJEMPLO
--  foto y escudo quedan a null: súbelos desde la app o con
--  decode('<base64>', 'base64') en un update.
-- ============================================================

insert into public.temporadas (nombre, inicio, fin, actual) values
    ('2026-27', '2026-08-01', '2027-06-30', true);

insert into public.jugadores (nombre, posicion, lesionado) values
                                                               ('Álex Roldán', 'Porteiro',       false),
                                                               ('Dani Pastor', 'Defensa',        false),
                                                               ('Hugo Ferrer', 'Defensa',        false),
                                                               ('Pau Mestre',  'Centrocampista', true),
                                                               ('Óscar Lledó', 'Dianteiro',      false),
                                                               ('Nico Vidal',  'Centrocampista', false);

-- Plantilla 2026-27 (enlazada por nombre para no depender de los id)
insert into public.plantilla (temporada_id, jugador_id, dorsal)
select t.id, j.id, p.dorsal
from (values
          ('Álex Roldán', 1),
          ('Dani Pastor', 2),
          ('Hugo Ferrer', 4),
          ('Pau Mestre',  6),
          ('Óscar Lledó', 9),
          ('Nico Vidal',  10)
     ) as p(nombre, dorsal)
         join public.jugadores  j on j.nombre = p.nombre
         join public.temporadas t on t.nombre = '2026-27';

insert into public.jugador_caracteristicas (jugador_id, descripcion, orden)
select j.id, c.descripcion, c.orden
from (values
          ('Álex Roldán', 'Reflexos',          1),
          ('Álex Roldán', 'Xogo de pés',       2),
          ('Álex Roldán', 'Penaltis',          3),
          ('Dani Pastor', 'Velocidade',        1),
          ('Dani Pastor', 'Centros',           2),
          ('Hugo Ferrer', 'Xogo aéreo',        1),
          ('Hugo Ferrer', 'Liderado',          2),
          ('Pau Mestre',  'Roubo',             1),
          ('Pau Mestre',  'Pase longo',        2),
          ('Óscar Lledó', 'Remate de cabeza',  1),
          ('Óscar Lledó', 'Xogo de costas',    2),
          ('Nico Vidal',  'Regate',            1),
          ('Nico Vidal',  'Faltas directas',   2)
     ) as c(nombre, descripcion, orden)
         join public.jugadores j on j.nombre = c.nombre;

insert into public.rivales (nombre) values
                                        ('Real Vega'), ('At. Sierra Norte'), ('SD Calzada'), ('Racing Olmedo'), ('CF Almendral');

-- Partidos (finalizado lo calcula el trigger)
insert into public.partidos (temporada_id, jornada, fecha_hora, rival_id, goles_favor, goles_contra)
select t.id, p.jornada, p.fecha_hora::timestamptz, r.id, p.gf, p.gc
from (values
          (11, '2026-10-25 17:00+01', 'CF Almendral',     2,    0),
          (12, '2026-11-01 12:00+01', 'Racing Olmedo',    1,    1),
          (13, '2026-11-08 17:00+01', 'SD Calzada',       3,    1),
          (14, '2026-11-15 18:30+01', 'At. Sierra Norte', null, null),
          (15, '2026-11-29 17:00+01', 'Real Vega',        null, null)
     ) as p(jornada, fecha_hora, rival, gf, gc)
         join public.rivales r    on r.nombre = p.rival
         join public.temporadas t on t.nombre = '2026-27';

insert into public.club_info (clave, valor, grupo, descripcion) values
                                                                    ('club.nombre',        'Shamchester United',                      'general',  'Nombre oficial'),
                                                                    ('club.fundacion',     '2026',                                    'general',  'Año de fundación'),
                                                                    ('contacto.email',     'oficina@shamchester.gal',                 'contacto', 'Correo de la oficina'),
                                                                    ('contacto.telefono',  '000 000 000',                             'contacto', null),
                                                                    ('redes.instagram',    'https://instagram.com/shamchesterunited', 'redes',    null),
                                                                    ('redes.x',            'https://x.com/shamchesterutd',            'redes',    null),
                                                                    ('redes.youtube',      'https://youtube.com/',                    'redes',    null),
                                                                    ('estadio.nombre',     'Estadio Shamchester United',              'estadio',  null),
                                                                    ('estadio.direccion',  'Av. de Shamchester, s/n',                 'estadio',  null),
                                                                    ('estadio.mapa_url',   'https://www.openstreetmap.org/',          'estadio',  'Enlace «Abrir no mapa»'),
                                                                    ('estadio.buses',      '4, 11',                                   'estadio',  'Líneas de bus');

insert into public.newsletter_suscriptores (email) values
    ('afeccionado@correo.gal');

-- ------------------------------------------------------------
--  Consultas de prueba
-- ------------------------------------------------------------
-- select * from v_proximo_partido;
-- select * from v_historico limit 5;
-- select * from v_plantilla_actual;
-- select clave, valor from club_info where grupo = 'redes';
-- select * from cron.job;   -- comprobar que la tarea programada existe
