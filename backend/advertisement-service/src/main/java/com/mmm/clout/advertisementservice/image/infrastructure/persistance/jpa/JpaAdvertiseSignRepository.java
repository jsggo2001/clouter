package com.mmm.clout.advertisementservice.image.infrastructure.persistance.jpa;

import com.mmm.clout.advertisementservice.image.domain.AdvertiseSign;
import com.mmm.clout.advertisementservice.image.domain.Image;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface JpaAdvertiseSignRepository extends JpaRepository<AdvertiseSign, Long> {

        List<AdvertiseSign> findByCampaign_Id(Long Id);

        List<AdvertiseSign> findByCampaign_IdIn(List<Long> idList);
}
