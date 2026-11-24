-- ============================================================
--  scripts-4 · Goles por jugador y partido
--  Necesario para "Intervenciones" (las fórmulas del Excel suman los goles).
-- ============================================================
begin;

alter table public.partido_estadisticas
    add column if not exists goles smallint not null default 0 check (goles >= 0);

comment on column public.partido_estadisticas.goles is 'Goles marcados por el jugador en el partido';

commit;

notify pgrst, 'reload schema';
