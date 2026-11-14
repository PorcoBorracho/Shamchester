package es.shamchester.action;

import org.apache.struts2.ActionSupport;

/**
 * Página partidos. Solo muestra la vista; sin lógica por ahora.
 */
public class PartidosAction extends ActionSupport {

    @Override
    public String execute() {
        return SUCCESS;
    }
}
