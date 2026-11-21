package es.shamchester.entity;

import es.shamchester.util.Fechas;
import jakarta.persistence.*;
import org.hibernate.annotations.Immutable;

import java.time.OffsetDateTime;

@Entity
@Immutable
@Table(name = "v_proximo_partido")
public class ProximoPartido {

    @Id
    private Long id;

    private Short jornada;

    @Column(name = "fecha_hora")
    private OffsetDateTime fechaHora;

    private String rival;

    private byte[] escudo;

    protected ProximoPartido() {
    }

    public Long getId() { return id; }
    public Short getJornada() { return jornada; }
    public OffsetDateTime getFechaHora() { return fechaHora; }
    public String getRival() { return rival; }
    public byte[] getEscudo() { return escudo; }
    public String getFechaLarga() { return Fechas.larga(fechaHora); }
    public String getFechaIso() { return fechaHora.toString(); }

    public String getEscudoDataUri() {
        if (escudo == null || escudo.length == 0) {
            return null;
        }
        String tipo = (escudo.length > 3 && (escudo[0] & 0xFF) == 0x89 && escudo[1] == 'P') ? "image/png"
                : (escudo.length > 4 && escudo[0] == '<') ? "image/svg+xml"
                  : "image/jpeg";
        return "data:" + tipo + ";base64," + java.util.Base64.getEncoder().encodeToString(escudo);
    }
}
