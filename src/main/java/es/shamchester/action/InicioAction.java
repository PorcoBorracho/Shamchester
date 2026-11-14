package es.shamchester.action;

import org.apache.struts2.ActionSupport;

/**
 * Página inicio. Solo muestra la vista; sin lógica por ahora.
 */
public class InicioAction extends ActionSupport {

    @Override
    public String execute() {
        return SUCCESS;
    }
}
