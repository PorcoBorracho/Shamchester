package es.shamchester.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

/**
 * Configuración raíz de Spring (sin Boot). La carga ContextLoaderListener desde web.xml.
 * Escanea los servicios de es.shamchester.service cuando existan.
 */
@Configuration
@Import(PersistenceConfig.class)
@ComponentScan(basePackages = "es.shamchester.service")
public class AppConfig {
}
