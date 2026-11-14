package es.shamchester.config;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.util.Map;
import java.util.stream.Collectors;

/**
 * Publica las variables del .env en el ámbito de aplicación
 * para que las JSP las lean como ${env.NOMBRE_VARIABLE}.
 * Las variables de la base de datos (SUPABASE_DB_*) no se publican nunca.
 */
@WebListener
public class EnvListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        Map<String, String> publicas = Env.all().entrySet().stream()
                .filter(e -> !e.getKey().startsWith("SUPABASE_DB_"))
                .collect(Collectors.toUnmodifiableMap(Map.Entry::getKey, Map.Entry::getValue));
        event.getServletContext().setAttribute("env", publicas);
    }
}
