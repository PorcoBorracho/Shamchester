package es.shamchester.config;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Lee el archivo .env de la raíz del proyecto (o la ruta de la variable ENV_FILE).
 * Las variables de entorno del sistema tienen prioridad sobre las del archivo.
 */
public final class Env {

    private static final Map<String, String> VALUES = load();

    private Env() {
    }

    public static String get(String key) {
        return VALUES.get(key);
    }

    public static String get(String key, String defaultValue) {
        return VALUES.getOrDefault(key, defaultValue);
    }

    public static Map<String, String> all() {
        return Collections.unmodifiableMap(VALUES);
    }

    private static Map<String, String> load() {
        Map<String, String> values = new LinkedHashMap<>();
        Path file = Path.of(System.getenv().getOrDefault("ENV_FILE", ".env"));
        if (Files.isRegularFile(file)) {
            try {
                List<String> lines = Files.readAllLines(file, StandardCharsets.UTF_8);
                for (String raw : lines) {
                    String line = raw.strip();
                    if (line.isEmpty() || line.startsWith("#") || !line.contains("=")) {
                        continue;
                    }
                    int i = line.indexOf('=');
                    String key = line.substring(0, i).strip();
                    String value = line.substring(i + 1).strip();
                    if (value.length() >= 2 && (value.startsWith("\"") && value.endsWith("\""))) {
                        value = value.substring(1, value.length() - 1);
                    }
                    values.put(key, value);
                }
            } catch (IOException e) {
                throw new IllegalStateException("No se pudo leer " + file.toAbsolutePath(), e);
            }
        }
        values.replaceAll((key, value) -> System.getenv().getOrDefault(key, value));
        return values;
    }
}
