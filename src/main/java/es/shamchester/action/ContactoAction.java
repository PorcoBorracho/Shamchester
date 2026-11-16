package es.shamchester.action;

import es.shamchester.model.FilaClubInfo;
import es.shamchester.service.ContactoService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.struts2.ActionSupport;

import java.util.List;

/**
 * Página contacto. Solo muestra la vista; sin lógica por ahora.
 */
public class ContactoAction extends ActionSupport {

    private static final Logger LOG = LogManager.getLogger(ContactoAction.class);

    private final ContactoService contactoService;

    private List<FilaClubInfo> clubInfos = List.of();

    private boolean error;

    public ContactoAction(ContactoService contactoService){this.contactoService = contactoService;}

    @Override
    public String execute() {
        try{
            clubInfos = contactoService.getInfoClub();
        } catch (Exception e){
            LOG.error("No se pudo cargar los datos de la BDD", e);
            error = true;
        }
        return SUCCESS;
    }

    /**
     * Busca el valor de la clave dentro de la lista de clubInfos
     */
    public String getValorInfo(String clave){
        return clubInfos.stream().filter(f -> clave.equals(f.clave())).map(FilaClubInfo::valor).findFirst().orElse("");
    }
}
