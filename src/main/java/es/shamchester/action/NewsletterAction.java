package es.shamchester.action;

import org.apache.struts2.ActionSupport;

/**
 * Página newsletter. Solo muestra la vista; sin lógica por ahora.
 */
public class NewsletterAction extends ActionSupport {

    @Override
    public String execute() {
        return SUCCESS;
    }
}
