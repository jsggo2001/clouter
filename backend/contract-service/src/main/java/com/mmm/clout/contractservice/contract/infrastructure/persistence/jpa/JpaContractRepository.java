package com.mmm.clout.contractservice.contract.infrastructure.persistence.jpa;

import com.mmm.clout.contractservice.contract.domain.Contract;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface JpaContractRepository extends JpaRepository<Contract, Long> {

    List<Contract> findAllByClouterInfo_ClouterId(Long id, Pageable pageable);

    List<Contract> findAllByAdvertiserInfo_AdvertiserId(Long id, Pageable pageable);

    Optional<Contract> findByAdvertiserInfo_AdvertiserIdAndClouterInfo_ClouterId(Long advertiserId, Long clouterId);
}
