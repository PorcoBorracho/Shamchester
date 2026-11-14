package es.shamchester.action;

import es.shamchester.service.PlantillaService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.struts2.ActionSupport;
import org.apache.struts2.interceptor.parameter.StrutsParameter;

import java.io.ByteArrayInputStream;
import java.io.InputStream;

/**
 * Sirve la foto (bytea) de un jugador: /jugador-foto?id=1
 */
public class JugadorFotoAction extends ActionSupport {

    private static final Logger LOG = LogManager.getLogger(JugadorFotoAction.class);

    public static final String NOT_FOUND = "notFound";

    private final PlantillaService plantillaService;
    private Long id;
    private byte[] bytes;

    public JugadorFotoAction(PlantillaService plantillaService) {
        this.plantillaService = plantillaService;
    }

    @Override
    public String execute() {
        try {
            bytes = plantillaService.foto(id).orElse(null);
        } catch (RuntimeException e) {
            LOG.error("No se pudo leer la foto del jugador {}", id, e);
            bytes = null;
        }
        if (bytes == null) {
            LOG.debug("Jugador {} sin foto", id);
            return NOT_FOUND;
        }
        return SUCCESS;
    }

    @StrutsParameter
    public void setId(Long id) {
        this.id = id;
    }

    public InputStream getInputStream() {
        return new ByteArrayInputStream(bytes);
    }

    public int getContentLength() {
        return bytes.length;
    }

    /** Tipo de imagen según los primeros bytes (la BDD no lo guarda). */
    public String getContentType() {
        if (bytes.length > 3 && (bytes[0] & 0xFF) == 0x89 && bytes[1] == 'P' && bytes[2] == 'N' && bytes[3] == 'G') {
            return "image/png";
        }
        if (bytes.length > 11 && bytes[0] == 'R' && bytes[1] == 'I' && bytes[8] == 'W' && bytes[9] == 'E' && bytes[10] == 'B' && bytes[11] == 'P') {
            return "image/webp";
        }
        return "image/jpeg";
    }
}
