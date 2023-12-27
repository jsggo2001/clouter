package com.mmm.clout.advertisementservice.advertisements.application;

import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.advertisements.domain.exception.CampaignNotFoundException;
import com.mmm.clout.advertisementservice.advertisements.domain.repository.CampaignRepository;
import com.mmm.clout.advertisementservice.apply.domain.Apply;
import com.mmm.clout.advertisementservice.apply.domain.repository.ApplyRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
public class EndCampaignProcessor {

    private final CampaignRepository campaignRepository;

    private final ApplyRepository applyRepository;

    @Transactional
    public Long execute(Long advertisementId) {
        Campaign campaign = campaignRepository.findById(advertisementId)
            .orElseThrow(CampaignNotFoundException::new);
        campaign.end();
        List<Apply> applyList = applyRepository.findByCampaign(campaign);
        applyList.forEach(Apply::end);
        return campaign.getId();
    }
}
