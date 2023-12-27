package com.mmm.clout.contractservice.contract.application;

import com.mmm.clout.contractservice.contract.application.command.CreateContractCommand;
import com.mmm.clout.contractservice.contract.domain.Contract;
import com.mmm.clout.contractservice.contract.domain.exception.DuplicateContractException;
import com.mmm.clout.contractservice.contract.domain.info.SelectAdrInfo;
import com.mmm.clout.contractservice.contract.domain.info.SelectClrInfo;
import com.mmm.clout.contractservice.contract.domain.provider.MemberProvider;
import com.mmm.clout.contractservice.contract.domain.provider.PointProvider;
import com.mmm.clout.contractservice.contract.domain.provider.dto.ReducePointRequest;
import com.mmm.clout.contractservice.contract.domain.repository.ContractRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@RequiredArgsConstructor
public class CreateContractProcessor {

    private final ContractRepository contractRepository;
    private final MemberProvider memberProvider;
    private final PointProvider pointProvider;

    @Transactional
    public Contract execute(CreateContractCommand command) {

        SelectClrInfo clouter = memberProvider.selectClouter(command.getClouterId()).getBody();
        SelectAdrInfo advertiser = memberProvider.selectAdvertiser(command.getAdvertiserId()).getBody();

        Contract contract = command.toEntity(clouter, advertiser);

        reduceAdvertiser(advertiser, clouter, contract.getPrice());

        return contractRepository.save(contract);
    }

    private void reduceAdvertiser(SelectAdrInfo adInfo, SelectClrInfo clouterInfo, Long price) {
        ReducePointRequest request = new ReducePointRequest(adInfo, clouterInfo, price);
        pointProvider.reduce(request);
    }
}
