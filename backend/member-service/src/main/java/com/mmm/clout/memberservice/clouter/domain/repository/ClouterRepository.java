package com.mmm.clout.memberservice.clouter.domain.repository;

import com.mmm.clout.memberservice.clouter.application.command.SearchCondition;
import com.mmm.clout.memberservice.clouter.domain.Channel;
import com.mmm.clout.memberservice.clouter.domain.Clouter;
import com.mmm.clout.memberservice.common.Category;
import com.mmm.clout.memberservice.common.Region;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface ClouterRepository {

    Clouter save(Clouter clouter);

    Clouter findById(Long userId);

    List<Clouter> findTop10ByOrderByAvgScoreDesc();

    List<Clouter> findByIdIn(List<Long> idList);

    List<Clouter> search(SearchCondition condition, Pageable pageable);

    JPAQuery<Clouter> getSearchCountQuery(SearchCondition condition);

    Optional<Clouter> findByPhoneNumber(String phoneNumber);
}
