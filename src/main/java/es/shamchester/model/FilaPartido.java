package es.shamchester.model;

import es.shamchester.util.Fechas;

import java.time.OffsetDateTime;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public record FilaPartido(Long id, Short jornada, OffsetDateTime fechaHora, String rival, Short golesFavor, Short golesContra,
                          String resultado, String videoUrl) {

    // watch?v=ID, youtu.be/ID, /embed/ID, /shorts/ID, /live/ID
    private static final Pattern YOUTUBE_ID = Pattern.compile(
            "^https?://(?:www\\.|m\\.)?(?:youtube\\.com/(?:watch\\?(?:.*&)?v=|embed/|shorts/|live/)|youtu\\.be/)([A-Za-z0-9_-]{11})(?:[?&#/].*)?$",
            Pattern.CASE_INSENSITIVE);

    public String fechaCorta() {
        return Fechas.corta(fechaHora);
    }

    /** Id de 11 caracteres del vídeo de YouTube, o null si no hay enlace válido. */
    public String youtubeId() {
        if (videoUrl == null || videoUrl.isBlank()) return null;
        Matcher m = YOUTUBE_ID.matcher(videoUrl.trim());
        return m.matches() ? m.group(1) : null;
    }

    public boolean tieneVideo() {
        return youtubeId() != null;
    }
}
