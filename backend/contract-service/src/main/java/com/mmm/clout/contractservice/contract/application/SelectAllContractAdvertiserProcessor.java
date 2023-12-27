package com.mmm.clout.contractservice.contract.application;

import com.mmm.clout.contractservice.contract.application.reader.ContractReader;
import com.mmm.clout.contractservice.contract.domain.Contract;
import com.mmm.clout.contractservice.contract.domain.repository.ContractRepository;
import com.querydsl.jpa.impl.JPAQuery;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.support.PageableExecutionUtils;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
public class SelectAllContractAdvertiserProcessor {

    private final ContractRepository contractRepository;

    public Page<ContractReader> execute(Long id, Pageable pageable) {
        List<Contract> contracts = contractRepository.findAllByAdvertiserInfoAdvertiserId(id, pageable);
        List<ContractReader> result = contracts.stream().map(contract -> new ContractReader(contract)).collect(Collectors.toList());

        JPAQuery<Contract> countQuery = contractRepository.findAllByAdvertiserInfoAdvertiserIdForCount(id);

        return PageableExecutionUtils.getPage(result, pageable, countQuery::fetchCount);
    }
}
