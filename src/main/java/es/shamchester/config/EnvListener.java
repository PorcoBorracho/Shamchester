package es.shamchester.config;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * Publica las variables del .env en el ámbito de aplicación
 * para que las JSP las lean como ${env.NOMBRE_VARIABLE}.
 */
@WebListener
public class EnvListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        event.getServletContext().setAttribute("env", Env.all());
    }
}
