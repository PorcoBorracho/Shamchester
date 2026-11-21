package es.shamchester.entity;

import jakarta.persistence.Basic;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "rivales")
public class Rival {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nombre;

    @Basic(fetch = FetchType.LAZY)
    private byte[] escudo;

    protected Rival() {
    }

    public Rival(String nombre) {
        this.nombre = nombre;
    }

    public Long getId() { return id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public byte[] getEscudo() { return escudo; }
    public void setEscudo(byte[] escudo) { this.escudo = escudo; }
}
