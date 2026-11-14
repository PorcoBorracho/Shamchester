package es.shamchester.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.time.LocalDate;

@Entity
@Table(name = "temporadas")
public class Temporada {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String nombre;
    private LocalDate inicio;
    private LocalDate fin;
    private boolean actual;

    public Long getId() { return id; }
    public String getNombre() { return nombre; }
    public LocalDate getInicio() { return inicio; }
    public LocalDate getFin() { return fin; }
    public boolean isActual() { return actual; }
}
