package es.shamchester.model;

import java.text.Normalizer;
import java.util.List;
import java.util.Locale;

/**
 * Datos de un jugador listos para la JSP (getters clásicos para OGNL).
 */
public class JugadorVista {

    private final Long id;
    private final short dorsal;
    private final String nombre;
    private final String posicion;
    private final String codigoPosicion;
    private final boolean lesionado;
    private final boolean conFoto;
    private final List<String> caracteristicas;
    private final EstadisticasJugador estadisticas;

    public JugadorVista(Long id, short dorsal, String nombre, String posicion,
                        boolean lesionado, boolean conFoto, List<String> caracteristicas,
                        EstadisticasJugador estadisticas) {
        this.id = id;
        this.dorsal = dorsal;
        this.nombre = nombre;
        this.posicion = posicion;
        this.codigoPosicion = codigo(posicion);
        this.lesionado = lesionado;
        this.conFoto = conFoto;
        this.caracteristicas = List.copyOf(caracteristicas);
        this.estadisticas = estadisticas == null ? EstadisticasJugador.VACIA : estadisticas;
    }

    public Long getId() { return id; }
    public short getDorsal() { return dorsal; }
    public String getNombre() { return nombre; }
    public String getPosicion() { return posicion; }
    /** POR, DEF, MED o DEL (clase CSS de la etiqueta); null si no se reconoce. */
    public String getCodigoPosicion() { return codigoPosicion; }
    public boolean isLesionado() { return lesionado; }
    public boolean isConFoto() { return conFoto; }
    public List<String> getCaracteristicas() { return caracteristicas; }
    public boolean isConCaracteristicas() { return !caracteristicas.isEmpty(); }
    public EstadisticasJugador getEstadisticas() { return estadisticas; }
    public boolean isPortero() { return "POR".equals(codigoPosicion); }

    /** La posición es texto libre en la BDD: se deduce el código por el comienzo de la palabra. */
    static String codigo(String posicion) {
        if (posicion == null) {
            return null;
        }
        String p = Normalizer.normalize(posicion, Normalizer.Form.NFD)
                .replaceAll("\\p{M}", "")
                .strip()
                .toLowerCase(Locale.ROOT);
        if (p.startsWith("port")) return "POR";                         // Porteiro / Portero
        if (p.startsWith("def") || p.startsWith("lat")) return "DEF";   // Defensa / Lateral
        if (p.startsWith("cent") || p.startsWith("med")) return "MED";  // Centrocampista / Medio
        if (p.startsWith("dian") || p.startsWith("del")) return "DEL";  // Dianteiro / Delantero
        return null;
    }
}
