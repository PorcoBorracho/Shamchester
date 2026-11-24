package es.shamchester.service;

import es.shamchester.model.EstadisticasJugador;
import es.shamchester.model.FilaCaracteristica;
import es.shamchester.model.FilaEstadisticas;
import es.shamchester.model.FilaPlantilla;
import es.shamchester.model.JugadorVista;
import es.shamchester.repository.JugadorCaracteristicaRepository;
import es.shamchester.repository.JugadorRepository;
import es.shamchester.repository.PlantillaRepository;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
public class PlantillaService {

    private static final Logger LOG = LogManager.getLogger(PlantillaService.class);

    private final PlantillaRepository plantilla;
    private final JugadorCaracteristicaRepository caracteristicas;
    private final JugadorRepository jugadores;

    public PlantillaService(PlantillaRepository plantilla,
                            JugadorCaracteristicaRepository caracteristicas,
                            JugadorRepository jugadores) {
        this.plantilla = plantilla;
        this.caracteristicas = caracteristicas;
        this.jugadores = jugadores;
    }

    /** Plantilla de la temporada actual con características y estadísticas globales. Tres consultas en total. */
    public List<JugadorVista> plantillaActual() {
        List<FilaPlantilla> filas = plantilla.findPlantillaActual();
        LOG.debug("Plantilla actual: {} jugadores", filas.size());
        if (filas.isEmpty()) {
            LOG.warn("No hay jugadores en la plantilla de la temporada actual (¿falta marcar una temporada como actual?)");
            return List.of();
        }
        List<Long> ids = filas.stream().map(FilaPlantilla::jugadorId).toList();
        Map<Long, List<String>> rasgos = caracteristicas
                .findByJugadores(ids)
                .stream()
                .collect(Collectors.groupingBy(FilaCaracteristica::jugadorId,
                        Collectors.mapping(FilaCaracteristica::descripcion, Collectors.toList())));

        Map<Long, EstadisticasJugador> stats = estadisticas(ids);

        List<JugadorVista> resultado = new ArrayList<>(filas.size());
        for (FilaPlantilla f : filas) {
            resultado.add(new JugadorVista(f.jugadorId(), f.dorsal(), f.nombre(), f.posicion(),
                    f.lesionado(), f.conFoto(), rasgos.getOrDefault(f.jugadorId(), List.of()),
                    stats.getOrDefault(f.jugadorId(), EstadisticasJugador.VACIA)));
        }
        return resultado;
    }

    private Map<Long, EstadisticasJugador> estadisticas(List<Long> ids) {
        Map<Long, EstadisticasJugador> base = jugadores.findEstadisticasGlobales(ids).stream()
                .collect(Collectors.toMap(FilaEstadisticas::getJugadorId, EstadisticasJugador::de));
        double maxPases = base.values().stream().mapToDouble(EstadisticasJugador::coefPases).max().orElse(0);
        double maxRegates = base.values().stream().mapToDouble(EstadisticasJugador::coefRegates).max().orElse(0);
        double maxDefensa = base.values().stream().mapToDouble(EstadisticasJugador::defensa50).max().orElse(0);
        double maxIntervenciones = base.values().stream().mapToDouble(EstadisticasJugador::intervenciones50).max().orElse(0);
        double maxGolesAsist = base.values().stream().mapToDouble(EstadisticasJugador::golesAsistencias50).max().orElse(0);
        return base.entrySet().stream().collect(Collectors.toMap(Map.Entry::getKey,
                e -> e.getValue().conRadar(maxPases, maxRegates, maxDefensa, maxIntervenciones, maxGolesAsist)));
    }

    public Optional<byte[]> foto(Long jugadorId) {
        return jugadorId == null ? Optional.empty() : jugadores.findFoto(jugadorId);
    }
}
