package es.shamchester.repository;

import es.shamchester.entity.Jugador;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface JugadorRepository extends JpaRepository<Jugador, Long> {

    /** Solo la foto (bytea) de un jugador. */
    @Query("select j.foto from Jugador j where j.id = :id and j.foto is not null")
    Optional<byte[]> findFoto(@Param("id") Long id);
}
