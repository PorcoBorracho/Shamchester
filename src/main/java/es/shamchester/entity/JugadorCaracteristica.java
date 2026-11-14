package es.shamchester.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "jugador_caracteristicas")
public class JugadorCaracteristica {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    private Jugador jugador;          // columna jugador_id

    private String descripcion;
    private short orden;

    public Long getId() { return id; }
    public Jugador getJugador() { return jugador; }
    public String getDescripcion() { return descripcion; }
    public short getOrden() { return orden; }
}
