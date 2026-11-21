package es.shamchester.repository;

import es.shamchester.entity.Partido;
import es.shamchester.model.FilaPartido;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface PartidoRepository extends JpaRepository<Partido, Long> {

    @Query("""
        select new es.shamchester.model.FilaPartido(
            p.id, p.jornada, p.fechaHora, r.nombre, p.golesFavor, p.golesContra, p.resultado)
            from Partido p
            join p.rival r
            join p.temporada t
         where t.actual = true
            and p.finalizado = true
         order by p.fechaHora desc
        """)
    List<FilaPartido> findHistorico();

}
