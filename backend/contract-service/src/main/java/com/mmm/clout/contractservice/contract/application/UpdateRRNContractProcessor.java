package com.mmm.clout.contractservice.contract.application;

import com.mmm.clout.contractservice.contract.domain.Contract;
import com.mmm.clout.contractservice.contract.domain.exception.NotFoundContractException;
import com.mmm.clout.contractservice.contract.domain.repository.ContractRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
public class UpdateRRNContractProcessor {

    private final ContractRepository contractRepository;

    @Transactional
    public Contract execute(Long id, String residentRegistrationNumber) {
        Contract contract = contractRepository.findById(id)
                .orElseThrow(() -> new NotFoundContractException());
        contract.updateResidentRegistrationNumber(residentRegistrationNumber);
        return contract;
    }
}
