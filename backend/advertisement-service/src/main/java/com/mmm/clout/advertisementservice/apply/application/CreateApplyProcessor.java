package com.mmm.clout.advertisementservice.apply.application;

import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.advertisements.domain.exception.CampaignNotFoundException;
import com.mmm.clout.advertisementservice.advertisements.domain.repository.CampaignRepository;
import com.mmm.clout.advertisementservice.apply.application.command.CreateApplyCommand;
import com.mmm.clout.advertisementservice.apply.domain.Applicant;
import com.mmm.clout.advertisementservice.apply.domain.Apply;
import com.mmm.clout.advertisementservice.apply.domain.exception.AlreadyCreatedApplyException;
import com.mmm.clout.advertisementservice.apply.domain.repository.ApplyRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
public class CreateApplyProcessor {

    private final ApplyRepository applyRepository;
    private final CampaignRepository campaignRepository;

    @Transactional
    public Apply execute(CreateApplyCommand command) {
        Campaign campaign = campaignRepository.findById(command.getAdvertisementId())
            .orElseThrow(CampaignNotFoundException::new);

        if (applyRepository.checkApplyExists(campaign, command.getClouterId())) {
            throw new AlreadyCreatedApplyException();
        }

        Apply apply = Apply.create(
            campaign,
            new Applicant(command.getClouterId()),
            command.getApplyMessage(),
            command.getHopeAdFee()
        );

        return applyRepository.save(apply);
    }
}
