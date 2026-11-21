package es.shamchester.service;

import es.shamchester.entity.ProximoPartido;
import es.shamchester.model.FilaPartido;
import es.shamchester.repository.PartidoRepository;
import es.shamchester.repository.ProximoPartidoRepository;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
public class PartidoService {

    private static final Logger LOG = LogManager.getLogger(PartidoService.class);
    private final ProximoPartidoRepository proximoPartidoRepository;
    private final PartidoRepository partidoRepository;

    public PartidoService(ProximoPartidoRepository proximoPartidoRepository, PartidoRepository partidoRepository){
        this.partidoRepository = partidoRepository;
        this.proximoPartidoRepository = proximoPartidoRepository;
    }

    public List<FilaPartido> getHistorico(){
        return partidoRepository.findHistorico();
    }

    public ProximoPartido getProximoRival(){
        Optional<ProximoPartido> resultado = proximoPartidoRepository.findProximo();
        return resultado.isEmpty() ? null : resultado.get();
    }
}
