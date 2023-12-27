package com.mmm.clout.advertisementservice.apply.infrastructure.persistence.jpa;

import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.apply.domain.Apply;
import com.mmm.clout.advertisementservice.apply.domain.Apply.ApplyStatus;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface JpaApplyRepository extends JpaRepository<Apply, Long>  {

    boolean existsByCampaignAndApplicant_ApplicantId(Campaign campaign, Long clouterId);

    List<Apply> findByCampaignId(Long advertisementId, Pageable pageable);

    List<Apply> findByCampaign(Campaign campaign);

    Optional<Apply> findByCampaign_IdAndApplicant_ApplicantId(Long advertiserId, Long clouterId);
}
