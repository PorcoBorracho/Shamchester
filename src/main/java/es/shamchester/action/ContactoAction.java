package es.shamchester.action;

import org.apache.struts2.ActionSupport;

/**
 * Página contacto. Solo muestra la vista; sin lógica por ahora.
 */
public class ContactoAction extends ActionSupport {

    @Override
    public String execute() {
        return SUCCESS;
    }
}
