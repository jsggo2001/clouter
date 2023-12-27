package com.mmm.clout.advertisementservice.advertisements.infrastructure.persistence.jpa;

import com.mmm.clout.advertisementservice.advertisements.domain.Advertisement;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import java.time.LocalDate;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;

public interface JpaCampaignRepository extends JpaRepository<Campaign, Long>,
    QuerydslPredicateExecutor<Campaign> {

    Page<Campaign> findByRegisterIdOrderByCreatedAtDesc(Long advertiserId, Pageable pageable);

    List<Campaign> findByIdIn(List<Long> adIdList);

}
