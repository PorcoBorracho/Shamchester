package es.shamchester.repository;

import es.shamchester.entity.ProximoPartido;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface ProximoPartidoRepository extends JpaRepository<ProximoPartido, Long> {
    @Query("select r.escudo from Rival r where r.id = :id and r.escudo is not null")
    Optional<byte[]> findEscudo(@Param("id") Long id);

    @Query("select p from ProximoPartido p")
    Optional<ProximoPartido> findProximo();
}
