package es.shamchester.action;

import es.shamchester.model.JugadorVista;
import es.shamchester.service.PlantillaService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.struts2.ActionSupport;

import java.util.List;

/**
 * Página plantilla: jugadores de la temporada actual desde Supabase.
 */
public class PlantillaAction extends ActionSupport {

    private static final Logger LOG = LogManager.getLogger(PlantillaAction.class);

    private final PlantillaService plantillaService;
    private List<JugadorVista> jugadores = List.of();
    private boolean error;

    public PlantillaAction(PlantillaService plantillaService) {
        this.plantillaService = plantillaService;
    }

    @Override
    public String execute() {
        try {
            jugadores = plantillaService.plantillaActual();
        } catch (RuntimeException e) {
            LOG.error("No se pudo cargar la plantilla desde la base de datos", e);
            error = true;
        }
        return SUCCESS;
    }

    public List<JugadorVista> getJugadores() {
        return jugadores;
    }

    public boolean isError() {
        return error;
    }
}
