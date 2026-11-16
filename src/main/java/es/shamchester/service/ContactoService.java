package es.shamchester.service;

import es.shamchester.model.FilaClubInfo;
import es.shamchester.repository.ClubInfoRepository;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional(readOnly = true)
public class ContactoService {

    private static final Logger LOG = LogManager.getLogger(ContactoService.class);
    private final ClubInfoRepository clubInfo;

    public ContactoService(ClubInfoRepository clubInfo){
        this.clubInfo = clubInfo;
    }

    public List<FilaClubInfo> getInfoClub(){
        return clubInfo.findAllClubInfo();
    }

}
