package es.shamchester.model;

import es.shamchester.util.Fechas;

import java.time.OffsetDateTime;

public record FilaPartido(Long id, Short jornada, OffsetDateTime fechaHora, String rival, Short golesFavor, Short golesContra, String resultado) {

    public String fechaCorta() {
        return Fechas.corta(fechaHora);
    }
}
