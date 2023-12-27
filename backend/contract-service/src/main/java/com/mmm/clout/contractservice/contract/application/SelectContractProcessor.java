package com.mmm.clout.contractservice.contract.application;

import com.mmm.clout.contractservice.contract.domain.Contract;
import com.mmm.clout.contractservice.contract.domain.exception.NotFoundContractException;
import com.mmm.clout.contractservice.contract.domain.repository.ContractRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class SelectContractProcessor {

    private final ContractRepository contractRepository;

    public Contract execute(Long id) {
        return contractRepository.findById(id).orElseThrow(() -> new NotFoundContractException());
    }
}
