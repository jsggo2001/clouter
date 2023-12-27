package com.mmm.clout.advertisementservice.apply.application;

import com.mmm.clout.advertisementservice.apply.application.command.CreateContractCommand;
import com.mmm.clout.advertisementservice.apply.domain.Apply;
import com.mmm.clout.advertisementservice.apply.domain.exception.ApplyNotFoundException;
import com.mmm.clout.advertisementservice.apply.domain.repository.ApplyRepository;
import com.mmm.clout.advertisementservice.common.msa.provider.ContractProvider;
import com.mmm.clout.advertisementservice.image.domain.AdvertiseSign;
import com.mmm.clout.advertisementservice.image.domain.repository.AdvertiseSignRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
public class SelectApplyForContractProcessor {

    private final ApplyRepository applyRepository;
    private final ContractProvider contractProvider;
    private final AdvertiseSignRepository advertiseSignRepository;

    @Transactional
    public void execute(Long applyId) {
        Apply apply = applyRepository.findById(applyId).orElseThrow(ApplyNotFoundException::new);
        apply.askForContract();

        String imagePath = advertiseSignRepository.findByAdvertisementId(apply.getCampaign().getId()).get(0).getPath();
        contractProvider.create(new CreateContractCommand(apply, imagePath));
    }
}
