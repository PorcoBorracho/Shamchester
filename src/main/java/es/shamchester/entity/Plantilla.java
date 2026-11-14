package es.shamchester.entity;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;

/** Relación jugador-temporada con el dorsal de esa temporada. */
@Entity
@Table(name = "plantilla")
public class Plantilla {

    @EmbeddedId
    private PlantillaId id;

    @MapsId("temporadaId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    private Temporada temporada;      // columna temporada_id

    @MapsId("jugadorId")
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    private Jugador jugador;          // columna jugador_id

    private short dorsal;

    public PlantillaId getId() { return id; }
    public Temporada getTemporada() { return temporada; }
    public Jugador getJugador() { return jugador; }
    public short getDorsal() { return dorsal; }
}
