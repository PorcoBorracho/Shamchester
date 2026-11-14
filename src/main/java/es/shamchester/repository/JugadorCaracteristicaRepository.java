package es.shamchester.repository;

import es.shamchester.entity.JugadorCaracteristica;
import es.shamchester.model.FilaCaracteristica;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.List;

public interface JugadorCaracteristicaRepository extends JpaRepository<JugadorCaracteristica, Long> {

    /** Características de varios jugadores en una sola consulta. */
    @Query("""
            select new es.shamchester.model.FilaCaracteristica(c.jugador.id, c.descripcion)
              from JugadorCaracteristica c
             where c.jugador.id in :ids
             order by c.orden, c.id
            """)
    List<FilaCaracteristica> findByJugadores(@Param("ids") Collection<Long> ids);
}
