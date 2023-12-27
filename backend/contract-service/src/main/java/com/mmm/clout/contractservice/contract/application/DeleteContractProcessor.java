package com.mmm.clout.contractservice.contract.application;

import com.mmm.clout.contractservice.contract.domain.Contract;
import com.mmm.clout.contractservice.contract.domain.exception.NotFoundContractException;
import com.mmm.clout.contractservice.contract.domain.provider.PointProvider;
import com.mmm.clout.contractservice.contract.domain.provider.dto.AddAdvertiserPointRequest;
import com.mmm.clout.contractservice.contract.domain.provider.dto.AddClouterPointRequest;
import com.mmm.clout.contractservice.contract.domain.repository.ContractRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
public class DeleteContractProcessor {

    private final ContractRepository contractRepository;
    private final PointProvider pointProvider;

    @Transactional
    public Long execute(Long id) {
        Contract contract = contractRepository.findById(id)
                .orElseThrow(() -> new NotFoundContractException());
        addAdvertiserPoint(contract);
        contractRepository.delete(contract);
        return id;
    }

    private void addAdvertiserPoint(Contract contract) {
        AddAdvertiserPointRequest request = new AddAdvertiserPointRequest(contract);
        pointProvider.add(request);
    }
}
