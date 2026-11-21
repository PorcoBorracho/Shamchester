create table public.partido_convocados (
                                           partido_id  bigint not null references public.partidos (id) on delete cascade,
                                           jugador_id  bigint not null references public.jugadores (id) on delete cascade,
                                           primary key (partido_id, jugador_id)
);

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

create trigger partido_convocados_plantilla
    before insert or update on public.partido_convocados
                         for each row execute function public.convocado_en_plantilla();

alter table public.partidos
    add column if not exists video_url text
        check (video_url ~* '^https://(www\.|m\.)?(youtube\.com|youtu\.be)/');

comment on column public.partidos.video_url is 'Enlace al vídeo del partido en YouTube (opcional)';

create or replace view public.v_historico as
select p.id, t.nombre as temporada, p.jornada, p.fecha_hora, r.nombre as rival,
       p.goles_favor, p.goles_contra, p.resultado, p.video_url
from public.partidos p
         join public.rivales r    on r.id = p.rival_id
         join public.temporadas t on t.id = p.temporada_id
where p.finalizado
order by p.fecha_hora desc;

alter view public.v_historico set (security_invoker = true);
