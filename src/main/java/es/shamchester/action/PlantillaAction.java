package es.shamchester.action;

import org.apache.struts2.ActionSupport;

/**
 * Página plantilla. Solo muestra la vista; sin lógica por ahora.
 */
public class PlantillaAction extends ActionSupport {

    @Override
    public String execute() {
        return SUCCESS;
    }
}
