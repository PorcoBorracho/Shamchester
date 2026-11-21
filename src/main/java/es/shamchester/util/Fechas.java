package es.shamchester.util;

import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

public final class Fechas {

    public static final Locale GALEGO = Locale.forLanguageTag("gl-ES");
    public static final ZoneId ZONA = ZoneId.of("Europe/Madrid");

    private static final DateTimeFormatter LARGA = DateTimeFormatter.ofPattern("EEEE d 'de' MMMM '·' HH:mm", GALEGO).withZone(ZONA);
    private static final DateTimeFormatter CORTA = DateTimeFormatter.ofPattern("d MMM", GALEGO).withZone(ZONA);

    private Fechas() {
    }

    public static String larga(OffsetDateTime fecha) {
        if (fecha == null) {
            return "";
        }
        String texto = LARGA.format(fecha);
        return texto.substring(0, 1).toUpperCase(GALEGO) + texto.substring(1);
    }

    public static String corta(OffsetDateTime fecha) {
        return fecha == null ? "" : CORTA.format(fecha).replace(".", "");
    }
}