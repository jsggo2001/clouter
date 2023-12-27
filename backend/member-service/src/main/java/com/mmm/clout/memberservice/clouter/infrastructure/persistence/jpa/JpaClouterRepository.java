package com.mmm.clout.memberservice.clouter.infrastructure.persistence.jpa;

import com.mmm.clout.memberservice.clouter.domain.Clouter;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.swing.text.html.Option;
import java.util.List;
import java.util.Optional;

public interface JpaClouterRepository extends JpaRepository<Clouter, Long> {
    List<Clouter> findTop10ByOrderByAvgScoreDesc();

    List<Clouter> findByIdIn(List<Long> idList);

    Optional<Clouter> findByPhoneNumber(String phonenumber);
}
