package com.mmm.clout.contractservice.contract.domain.repository;


import com.mmm.clout.contractservice.contract.domain.Contract;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface ContractRepository {

    Contract save(Contract contract);

    Optional<Contract> findById(Long id);

    void delete(Contract contract);

    List<Contract> findAllByClouterInfoClouterId(Long clouterId, Pageable pageable);

    List<Contract> findAllByAdvertiserInfoAdvertiserId(Long advertiserId, Pageable pageable);

    public Optional<Contract> findByAdvertiserInfo_AdvertiserIdAndClouterInfo_ClouterId(
            Long advertiserId,
            Long clouterId
    );

    JPAQuery<Contract> findAllByClouterInfoClouterIdForCount(Long id);

    JPAQuery<Contract> findAllByAdvertiserInfoAdvertiserIdForCount(Long id);
}
