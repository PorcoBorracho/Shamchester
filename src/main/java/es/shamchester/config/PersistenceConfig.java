package es.shamchester.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import jakarta.persistence.EntityManagerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;
import java.util.Map;

/**
 * Conexión a Supabase (PostgreSQL) con JPA/Hibernate y Spring Data.
 * Todos los datos de conexión salen del .env (variables SUPABASE_DB_*).
 *
 * Entidades:     es.shamchester.entity
 * Repositorios:  es.shamchester.repository
 *
 * El esquema se gestiona con los scripts de /scripts: Hibernate no crea ni modifica tablas.
 */
@Configuration
@EnableTransactionManagement
@EnableJpaRepositories(basePackages = "es.shamchester.repository")
public class PersistenceConfig {

    @Bean(destroyMethod = "close")
    public DataSource dataSource() {
        String host = required("SUPABASE_DB_HOST");
        String port = Env.get("SUPABASE_DB_PORT", "5432");
        String name = Env.get("SUPABASE_DB_NAME", "postgres");

        HikariConfig cfg = new HikariConfig();
        cfg.setPoolName("supabase");
        cfg.setDriverClassName("org.postgresql.Driver");
        cfg.setJdbcUrl("jdbc:postgresql://" + host + ":" + port + "/" + name + "?sslmode=require");
        cfg.setUsername(required("SUPABASE_DB_USER"));
        cfg.setPassword(required("SUPABASE_DB_PASSWORD"));
        cfg.setMaximumPoolSize(Integer.parseInt(Env.get("SUPABASE_DB_POOL_SIZE", "5")));
        cfg.setMinimumIdle(0);
        // Puerto 6543 = Transaction pooler: no admite sentencias preparadas en servidor
        if ("6543".equals(port)) {
            cfg.addDataSourceProperty("prepareThreshold", "0");
        }
        // Arranca aunque la BDD no responda; la conexión se abre en la primera consulta
        cfg.setInitializationFailTimeout(-1);
        return new HikariDataSource(cfg);
    }

    @Bean
    public LocalContainerEntityManagerFactoryBean entityManagerFactory(DataSource dataSource) {
        LocalContainerEntityManagerFactoryBean emf = new LocalContainerEntityManagerFactoryBean();
        emf.setDataSource(dataSource);
        emf.setPackagesToScan("es.shamchester.entity");
        emf.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
        emf.setJpaPropertyMap(Map.of(
                "hibernate.dialect", "org.hibernate.dialect.PostgreSQLDialect",
                "hibernate.hbm2ddl.auto", "none",
                // No consulta la BDD al arrancar (dialecto fijado arriba)
                "hibernate.boot.allow_jdbc_metadata_access", "false",
                // fechaHora -> fecha_hora
                "hibernate.physical_naming_strategy",
                "org.hibernate.boot.model.naming.CamelCaseToUnderscoresNamingStrategy",
                "hibernate.jdbc.time_zone", "UTC",
                "hibernate.show_sql", Env.get("APP_ENV", "").equals("development") ? "true" : "false"
        ));
        return emf;
    }

    @Bean
    public PlatformTransactionManager transactionManager(EntityManagerFactory emf) {
        return new JpaTransactionManager(emf);
    }

    private static String required(String key) {
        String value = Env.get(key);
        if (value == null || value.isBlank()) {
            throw new IllegalStateException("Falta la variable " + key + " en el .env");
        }
        return value;
    }
}
