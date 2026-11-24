package es.shamchester.repository;

import es.shamchester.entity.Jugador;
import es.shamchester.model.FilaEstadisticas;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

public interface JugadorRepository extends JpaRepository<Jugador, Long> {

    /** Solo la foto (bytea) de un jugador. */
    @Query("select j.foto from Jugador j where j.id = :id and j.foto is not null")
    Optional<byte[]> findFoto(@Param("id") Long id);

    /**
     * Totales de todas las temporadas para varios jugadores en una sola consulta
     * (columnas base de "Resumen automático" del Excel).
     * Solo cuentan los partidos en los que el jugador jugó algún minuto.
     */
    @Query(nativeQuery = true, value = """
            select e.jugador_id                  as "jugadorId",
                   count(*)                      as "partidos",
                   sum(e.min_p1 + e.min_p2)      as "minutos",
                   sum(e.pase_bueno)             as "pasesBuenos",
                   sum(e.pase_malo)              as "pasesMalos",
                   sum(e.pase_portero_bueno)     as "ppBuenos",
                   sum(e.pase_portero_malo)      as "ppMalos",
                   sum(e.regate_bueno)           as "regatesBuenos",
                   sum(e.regate_malo)            as "regatesMalos",
                   sum(e.accion_defensiva)       as "defensa",
                   sum(e.paradas)                as "paradas",
                   sum(e.goles)                  as "goles"
              from public.partido_estadisticas e
             where e.jugador_id in (:ids)
               and e.min_p1 + e.min_p2 > 0
             group by e.jugador_id
            """)
    List<FilaEstadisticas> findEstadisticasGlobales(@Param("ids") Collection<Long> ids);
}
