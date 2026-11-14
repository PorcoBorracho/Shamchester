package es.shamchester.entity;

import jakarta.persistence.Embeddable;

import java.io.Serializable;
import java.util.Objects;

/** Clave compuesta de plantilla: (temporada_id, jugador_id). */
@Embeddable
public class PlantillaId implements Serializable {

    private Long temporadaId;
    private Long jugadorId;

    protected PlantillaId() {
    }

    public PlantillaId(Long temporadaId, Long jugadorId) {
        this.temporadaId = temporadaId;
        this.jugadorId = jugadorId;
    }

    public Long getTemporadaId() { return temporadaId; }
    public Long getJugadorId() { return jugadorId; }

    @Override
    public boolean equals(Object o) {
        return o instanceof PlantillaId other
                && Objects.equals(temporadaId, other.temporadaId)
                && Objects.equals(jugadorId, other.jugadorId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(temporadaId, jugadorId);
    }
}
