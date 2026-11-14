package es.shamchester.config;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.core.config.Configurator;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

/**
 * Configura los logs con LOG_DIR y LOG_LEVEL del .env.
 * Va declarado el primero en web.xml para que actúe antes que Spring y Struts.
 */
public class LogConfigListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        Path dir = Path.of(Env.get("LOG_DIR", "logs")).toAbsolutePath().normalize();
        String level = Env.get("LOG_LEVEL", "info");
        String aviso = null;
        try {
            Files.createDirectories(dir);
        } catch (IOException e) {
            aviso = "No se pudo crear la carpeta de logs " + dir + ": " + e.getMessage();
        }

        System.setProperty("shamchester.log.dir", dir.toString());
        System.setProperty("shamchester.log.level", level);
        // Por si log4j ya se había iniciado con los valores por defecto
        Configurator.reconfigure();

        Logger log = LogManager.getLogger(LogConfigListener.class);
        if (aviso != null) {
            log.error(aviso);
        }
        log.info("Logs en {} (nivel {})", dir, level);
    }
}
