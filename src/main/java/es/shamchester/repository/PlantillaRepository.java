package es.shamchester.repository;

import es.shamchester.entity.Plantilla;
import es.shamchester.entity.PlantillaId;
import es.shamchester.model.FilaPlantilla;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface PlantillaRepository extends JpaRepository<Plantilla, PlantillaId> {

    /** Plantilla de la temporada actual sin cargar las fotos (solo si existen). */
    @Query("""
            select new es.shamchester.model.FilaPlantilla(
                       p.dorsal, j.id, j.nombre, j.posicion, j.lesionado,
                       case when j.foto is null then false else true end)
              from Plantilla p
              join p.jugador j
              join p.temporada t
             where t.actual = true
             order by j.lesionado, p.dorsal
            """)
    List<FilaPlantilla> findPlantillaActual();
}
