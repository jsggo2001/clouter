package com.mmm.clout.advertisementservice.image.infrastructure.persistance.jpa;

import com.mmm.clout.advertisementservice.image.domain.Image;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface JpaImageRepository extends JpaRepository<Image, Long> {

        List<Image> findByCampaign_Id(Long Id);

        List<Image> findByCampaign_IdIn(List<Long> idList);

        void deleteByCampaign_Id(Long id);
}
