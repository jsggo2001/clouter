package com.mmm.clout.advertisementservice.advertisements.domain.repository;

import com.mmm.clout.advertisementservice.advertisements.application.command.SearchCondition;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.querydsl.jpa.impl.JPAQuery;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface CampaignRepository {

    Campaign save(Campaign campaign);

    Optional<Campaign> findById(Long advertisementId);

    List<Campaign> getTop10List();

    Page<Campaign> getCampainListByAdvertiserId(Long advertiserId, Pageable pageable);

    List<Campaign> findByIdIn(List<Long> adIdList);

    List<Campaign> search(SearchCondition condition, Pageable pageable);

    JPAQuery<Campaign> getSearchCountQuery(SearchCondition condition);

}
