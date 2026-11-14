package es.shamchester.model;

/** Fila ligera de la plantilla (resultado de consulta JPQL, sin la foto). */
public record FilaPlantilla(short dorsal, Long jugadorId, String nombre, String posicion,
                            boolean lesionado, boolean conFoto) {
}
