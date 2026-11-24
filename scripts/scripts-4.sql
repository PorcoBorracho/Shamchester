begin;

alter table public.partido_estadisticas
    add column if not exists goles smallint not null default 0 check (goles >= 0);

comment on column public.partido_estadisticas.goles is 'Goles marcados por el jugador en el partido';

commit;

begin;

alter table public.partido_estadisticas
    add column if not exists asist smallint not null default 0 check (asist >= 0);

comment on column public.partido_estadisticas.asist is 'Goles marcados por el jugador en el partido';

commit;

notify pgrst, 'reload schema';