package com.mmm.clout.advertisementservice.image.infrastructure.persistance;

import com.mmm.clout.advertisementservice.image.domain.AdvertiseSign;
import com.mmm.clout.advertisementservice.image.domain.Image;
import com.mmm.clout.advertisementservice.image.domain.repository.AdvertiseSignRepository;
import com.mmm.clout.advertisementservice.image.domain.repository.ImageRepository;
import com.mmm.clout.advertisementservice.image.infrastructure.persistance.jpa.JpaAdvertiseSignRepository;
import com.mmm.clout.advertisementservice.image.infrastructure.persistance.jpa.JpaImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class AdvertiseSignRepositoryAdapter implements AdvertiseSignRepository {

    private final JpaAdvertiseSignRepository jpaAdvertiseSignRepository;

    @Override
    public AdvertiseSign save(AdvertiseSign advertiseSign) {return jpaAdvertiseSignRepository.save(advertiseSign);}

    @Override
    public List<AdvertiseSign> findByAdvertisementId(Long advertisementId) {
        return jpaAdvertiseSignRepository.findByCampaign_Id(advertisementId);
    }

    @Override
    public List<AdvertiseSign> findByCampaignIdIn(List<Long> idList) {
        return jpaAdvertiseSignRepository.findByCampaign_IdIn(idList);
    }

    @Override
    public AdvertiseSign delete(Long id){
        AdvertiseSign advertiseSign = jpaAdvertiseSignRepository.findById(id)
                .orElseThrow(IllegalAccessError::new);

        jpaAdvertiseSignRepository.deleteById(id);
        return advertiseSign;
    }

    @Override
    public AdvertiseSign find(Long id){
        AdvertiseSign advertiseSign = jpaAdvertiseSignRepository.findById(id)
                .orElseThrow(IllegalAccessError::new);

        return advertiseSign;
    }
}
