package com.mmm.clout.memberservice.advertiser.infrastructure.persistence;

import com.mmm.clout.memberservice.advertiser.domain.Advertiser;
import com.mmm.clout.memberservice.advertiser.domain.repository.AdvertiserRepository;
import com.mmm.clout.memberservice.advertiser.domain.exception.NotFoundAdvertiser;
import com.mmm.clout.memberservice.advertiser.infrastructure.persistence.jpa.JpaAdvertiserRepository;
import com.mmm.clout.memberservice.clouter.domain.Clouter;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class AdvertiserRepositoryAdapter implements AdvertiserRepository {

    private final JpaAdvertiserRepository jpaAdvertisementRepository;

    @Override
    public Advertiser save(Advertiser advertiser) {
        return jpaAdvertisementRepository.save(advertiser);
    }

    @Override
    public Advertiser findById(Long userId) {
        return jpaAdvertisementRepository.findById(userId).orElseThrow(
            () -> new NotFoundAdvertiser()
        );
    }
    @Override
    public List<Advertiser> findByIdIn(List<Long> idList) {
        return jpaAdvertisementRepository.findByIdIn(idList);
    }

    @Override
    public Optional<Advertiser> findByCompanyInfo_ManagerPhoneNumber(String phoneNumber) {
        return jpaAdvertisementRepository.findByCompanyInfo_ManagerPhoneNumber(phoneNumber);
    }
}
