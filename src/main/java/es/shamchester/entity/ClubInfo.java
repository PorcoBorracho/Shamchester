package es.shamchester.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.util.Date;

@Entity
@Table(name = "club_info")
public class ClubInfo {

    @Id
    private String clave;
    private String valor;
    private String grupo;
    private String descripcion;
    private Date actualizado;

    public String getClave() {return clave;}
    public String getValor() {return valor;}
    public String getGrupo() {return grupo;}
    public String getDescripcion() {return descripcion;}
    public Date getActualizado() {return actualizado;}
}
