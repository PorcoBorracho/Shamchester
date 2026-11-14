package es.shamchester.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "jugadores")
public class Jugador {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String nombre;
    private String posicion;
    private boolean lesionado;
    /** bytea. Las consultas de listado no la cargan: se sirve aparte (ver JugadorRepository.findFoto). */
    private byte[] foto;

    public Long getId() { return id; }
    public String getNombre() { return nombre; }
    public String getPosicion() { return posicion; }
    public boolean isLesionado() { return lesionado; }
    public byte[] getFoto() { return foto; }
}
