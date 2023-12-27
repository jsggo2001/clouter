package com.mmm.clout.contractservice.contract.infrastructure.persistence;


import com.mmm.clout.contractservice.contract.domain.Contract;
import com.mmm.clout.contractservice.contract.domain.QContract;
import com.mmm.clout.contractservice.contract.domain.repository.ContractRepository;
import com.mmm.clout.contractservice.contract.infrastructure.persistence.jpa.JpaContractRepository;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

import static com.mmm.clout.contractservice.contract.domain.QContract.contract;

@RequiredArgsConstructor
public class ContractRepositoryAdapter implements ContractRepository {

    private final JpaContractRepository JpaContractRepository;
    private final JPAQueryFactory queryFactory;

    @Override
    public Contract save(Contract contract) {
        return JpaContractRepository.save(contract);
    }

    @Override
    public Optional<Contract> findById(Long id) {
        return JpaContractRepository.findById(id);
    }

    @Override
    public void delete(Contract contract) {
        JpaContractRepository.delete(contract);
    }

    @Override
    public List<Contract> findAllByClouterInfoClouterId(Long clouterId, Pageable pageable) {
        return JpaContractRepository.findAllByClouterInfo_ClouterId(clouterId, pageable);
    }

    @Override
    public List<Contract> findAllByAdvertiserInfoAdvertiserId(Long advertiserId, Pageable pageable) {
        return JpaContractRepository.findAllByAdvertiserInfo_AdvertiserId(advertiserId, pageable);
    }

    @Override
    public Optional<Contract> findByAdvertiserInfo_AdvertiserIdAndClouterInfo_ClouterId(
            Long advertiserId,
            Long clouterId
            ) {
        return JpaContractRepository.findByAdvertiserInfo_AdvertiserIdAndClouterInfo_ClouterId(
                advertiserId,
                clouterId
                );
    }

    @Override
    public JPAQuery<Contract> findAllByClouterInfoClouterIdForCount(Long clouterId) {
        JPAQuery<Contract> countQuery = queryFactory.query()
            .select(contract)
            .from(contract)
            .where(contract.clouterInfo.clouterId.eq(clouterId));
        return countQuery;
    }

    @Override
    public JPAQuery<Contract> findAllByAdvertiserInfoAdvertiserIdForCount(Long advertiseId) {
        JPAQuery<Contract> countQuery = queryFactory.query()
            .select(contract)
            .from(contract)
            .where(contract.advertiserInfo.advertiserId.eq(advertiseId));
        return countQuery;
    }
}
