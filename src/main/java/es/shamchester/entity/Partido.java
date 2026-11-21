package es.shamchester.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

import java.time.OffsetDateTime;

@Entity
@Table(name = "partidos")
public class Partido {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "temporada_id")
    private Temporada temporada;

    private Short jornada;

    @Column(name = "fecha_hora", nullable = false)
    private OffsetDateTime fechaHora;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "rival_id")
    private Rival rival;

    @Column(name = "goles_favor")
    private Short golesFavor;

    @Column(name = "goles_contra")
    private Short golesContra;

    @Column(insertable = false, updatable = false)
    private boolean finalizado;

    @Column(insertable = false, updatable = false, length = 1)
    private String resultado;

    protected Partido() {
    }

    public Partido(Temporada temporada, Short jornada, OffsetDateTime fechaHora, Rival rival) {
        this.temporada = temporada;
        this.jornada = jornada;
        this.fechaHora = fechaHora;
        this.rival = rival;
    }

    public Long getId() { return id; }

    public Temporada getTemporada() { return temporada; }
    public void setTemporada(Temporada temporada) { this.temporada = temporada; }

    public Short getJornada() { return jornada; }
    public void setJornada(Short jornada) { this.jornada = jornada; }

    public OffsetDateTime getFechaHora() { return fechaHora; }
    public void setFechaHora(OffsetDateTime fechaHora) { this.fechaHora = fechaHora; }

    public Rival getRival() { return rival; }
    public void setRival(Rival rival) { this.rival = rival; }

    public Short getGolesFavor() { return golesFavor; }
    public void setGolesFavor(Short golesFavor) { this.golesFavor = golesFavor; }

    public Short getGolesContra() { return golesContra; }
    public void setGolesContra(Short golesContra) { this.golesContra = golesContra; }

    public boolean isFinalizado() { return finalizado; }

    public String getResultado() { return resultado; }
}
