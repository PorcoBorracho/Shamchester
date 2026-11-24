
begin;


create table if not exists public.partido_convocados (
                                                         partido_id  bigint not null,
                                                         jugador_id  bigint not null,
                                                         primary key (partido_id, jugador_id)
    );

do $$
begin
    if exists (select 1 from information_schema.columns
               where table_schema = 'public' and table_name = 'partido_convocados'
                 and column_name = 'temporada_id') then
drop view if exists public.v_convocados;   -- usa temporada_id; se recrea abajo
alter table public.partido_convocados
drop constraint if exists partido_convocados_partido_id_temporada_id_fkey,
            drop constraint if exists partido_convocados_temporada_id_jugador_id_fkey;
alter table public.partido_convocados drop column temporada_id;
alter table public.partidos drop constraint if exists partidos_id_temporada_key;
raise notice 'partido_convocados migrada a la versión con trigger';
end if;
end $$;

-- Claves foráneas simples (se recrean para dejarlas siempre igual)
alter table public.partido_convocados
drop constraint if exists partido_convocados_partido_id_fkey,
    drop constraint if exists partido_convocados_jugador_id_fkey;
alter table public.partido_convocados
    add constraint partido_convocados_partido_id_fkey
        foreign key (partido_id) references public.partidos (id) on delete cascade,
    add constraint partido_convocados_jugador_id_fkey
        foreign key (jugador_id) references public.jugadores (id) on delete cascade;

-- Solo se puede convocar a jugadores de la plantilla de la temporada del partido
create or replace function public.convocado_en_plantilla()
returns trigger language plpgsql as $$
begin
    if not exists (
        select 1 from public.plantilla pl
        join public.partidos p on p.temporada_id = pl.temporada_id
        where p.id = new.partido_id and pl.jugador_id = new.jugador_id
    ) then
        raise exception 'El jugador % no está en la plantilla de la temporada del partido', new.jugador_id
            using errcode = '23503';
end if;
return new;
end $$;

drop trigger if exists partido_convocados_plantilla on public.partido_convocados;
create trigger partido_convocados_plantilla
    before insert or update on public.partido_convocados
                         for each row execute function public.convocado_en_plantilla();

alter table public.partido_convocados enable row level security;
drop policy if exists lectura_publica on public.partido_convocados;
create policy lectura_publica on public.partido_convocados for select using (true);


create table if not exists public.partido_estadisticas (
                                                           partido_id          bigint   not null,
                                                           jugador_id          bigint   not null,
                                                           pase_bueno          smallint not null default 0 check (pase_bueno >= 0),
    pase_malo           smallint not null default 0 check (pase_malo >= 0),
    pase_portero_bueno  smallint not null default 0 check (pase_portero_bueno >= 0),
    pase_portero_malo   smallint not null default 0 check (pase_portero_malo >= 0),
    regate_bueno        smallint not null default 0 check (regate_bueno >= 0),
    regate_malo         smallint not null default 0 check (regate_malo >= 0),
    accion_defensiva    smallint not null default 0 check (accion_defensiva >= 0),
    min_p1              smallint not null default 0 check (min_p1 between 0 and 90),  -- minutos 1.ª parte
    min_p2              smallint not null default 0 check (min_p2 between 0 and 90),  -- minutos 2.ª parte
    actualizado         timestamptz not null default now(),
    primary key (partido_id, jugador_id),
    -- Solo tiene estadísticas quien estuvo convocado; si se le quita, se borran
    foreign key (partido_id, jugador_id)
    references public.partido_convocados (partido_id, jugador_id) on delete cascade
    );

alter table public.partido_estadisticas
    add column if not exists paradas smallint not null default 0 check (paradas >= 0);

create index if not exists partido_estadisticas_jugador on public.partido_estadisticas (jugador_id);

comment on table  public.partido_estadisticas         is 'Estadísticas por jugador y partido';
comment on column public.partido_estadisticas.paradas is 'Paradas del portero';

alter table public.partido_estadisticas enable row level security;
drop policy if exists lectura_publica on public.partido_estadisticas;
create policy lectura_publica on public.partido_estadisticas for select using (true);

create or replace view public.v_convocados as
select c.partido_id, pl.dorsal, j.id as jugador_id, j.nombre, j.posicion, j.lesionado
from public.partido_convocados c
         join public.partidos  p on p.id = c.partido_id
         join public.jugadores j on j.id = c.jugador_id
         left join public.plantilla pl on pl.temporada_id = p.temporada_id and pl.jugador_id = c.jugador_id
order by c.partido_id, pl.dorsal;

create or replace view public.v_estadisticas_partido as
select e.partido_id, p.temporada_id, pl.dorsal, j.id as jugador_id, j.nombre, j.posicion,
       e.pase_bueno, e.pase_malo, e.pase_portero_bueno, e.pase_portero_malo,
       e.regate_bueno, e.regate_malo, e.accion_defensiva,
       e.min_p1, e.min_p2, e.min_p1 + e.min_p2 as minutos,
       e.paradas
from public.partido_estadisticas e
         join public.partidos  p  on p.id = e.partido_id
         join public.jugadores j  on j.id = e.jugador_id
         left join public.plantilla pl on pl.temporada_id = p.temporada_id and pl.jugador_id = e.jugador_id
order by e.partido_id, pl.dorsal;

create or replace view public.v_estadisticas_temporada as
select t.id as temporada_id, t.nombre as temporada, j.id as jugador_id, j.nombre,
       count(*)                                   as partidos,
       sum(e.min_p1 + e.min_p2)                   as minutos,
       sum(e.pase_bueno)                          as pase_bueno,
       sum(e.pase_malo)                           as pase_malo,
       round(100.0 * sum(e.pase_bueno) / nullif(sum(e.pase_bueno + e.pase_malo), 0), 1) as pct_pase,
       sum(e.pase_portero_bueno)                  as pase_portero_bueno,
       sum(e.pase_portero_malo)                   as pase_portero_malo,
       sum(e.regate_bueno)                        as regate_bueno,
       sum(e.regate_malo)                         as regate_malo,
       round(100.0 * sum(e.regate_bueno) / nullif(sum(e.regate_bueno + e.regate_malo), 0), 1) as pct_regate,
       sum(e.accion_defensiva)                    as accion_defensiva,
       sum(e.paradas)                             as paradas
from public.partido_estadisticas e
         join public.partidos   p on p.id = e.partido_id
         join public.temporadas t on t.id = p.temporada_id
         join public.jugadores  j on j.id = e.jugador_id
group by t.id, t.nombre, j.id, j.nombre;

alter view public.v_convocados             set (security_invoker = true);
alter view public.v_estadisticas_partido   set (security_invoker = true);
alter view public.v_estadisticas_temporada set (security_invoker = true);

commit;

notify pgrst, 'reload schema';
