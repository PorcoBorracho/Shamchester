package es.shamchester.repository;

import es.shamchester.entity.ClubInfo;
import es.shamchester.model.FilaClubInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ClubInfoRepository extends JpaRepository<ClubInfo, String> {

    @Query("""
        select new es.shamchester.model.FilaClubInfo(c.clave, c.valor, c.grupo, c.descripcion, c.actualizado)
        from ClubInfo c
        order by c.clave
    """)
    List<FilaClubInfo> findAllClubInfo();
}
