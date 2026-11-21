package es.shamchester.action;

import es.shamchester.entity.ProximoPartido;
import es.shamchester.model.FilaPartido;
import es.shamchester.service.PartidoService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.struts2.ActionSupport;

import java.util.List;

/**
 * Página partidos. Solo muestra la vista; sin lógica por ahora.
 */
public class PartidosAction extends ActionSupport {

    private static final Logger LOG = LogManager.getLogger(PartidosAction.class);
    private final PartidoService partidoService;
    private boolean error;

    private List<FilaPartido> historico = List.of();
    private ProximoPartido proximoPartido;

    public PartidosAction(PartidoService partidoService){this.partidoService=partidoService;}

    @Override
    public String execute() {
        try{
            historico = partidoService.getHistorico();
            proximoPartido = partidoService.getProximoRival();
        } catch (Exception e){
            LOG.error("No se pudo cargar los datos de la BDD", e);
            error = true;
        }
        return SUCCESS;
    }

    public List<FilaPartido> getHistorico(){return historico;}
    public ProximoPartido getProximoPartido(){return proximoPartido;}

    public boolean isConHistorico() {
        return historico != null && !historico.isEmpty();
    }

}
