package com.mmm.clout.advertisementservice.advertisements.application;

import com.mmm.clout.advertisementservice.advertisements.application.reader.CampaignReader;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.advertisements.domain.exception.CampaignNotFoundException;
import com.mmm.clout.advertisementservice.advertisements.domain.repository.CampaignRepository;
import com.mmm.clout.advertisementservice.common.msa.info.AdvertiserInfo;
import com.mmm.clout.advertisementservice.common.msa.provider.MemberProvider;
import com.mmm.clout.advertisementservice.image.domain.AdvertiseSign;
import com.mmm.clout.advertisementservice.image.domain.Image;
import com.mmm.clout.advertisementservice.image.domain.repository.AdvertiseSignRepository;
import com.mmm.clout.advertisementservice.image.domain.repository.ImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
public class GetCampaignProcessor {

    private final CampaignRepository campaignRepository;
    private final MemberProvider memberProvider;
    private final ImageRepository imageRepository;
    private final AdvertiseSignRepository advertiseSignRepository;

    @Transactional(readOnly = true)
    public CampaignReader execute(Long advertisementId) {
        Campaign campaign = campaignRepository.findById(advertisementId)
            .orElseThrow(CampaignNotFoundException::new);
        campaign.initialize();
        AdvertiserInfo advertiserInfo = memberProvider.getAdvertiserInfoByMemberId(
            campaign.getAdvertiserId());

        List<Image> findImage = imageRepository.findByAdvertisementId(advertisementId);

        AdvertiseSign signImage = advertiseSignRepository.findByAdvertisementId(advertisementId).get(0);

        return new CampaignReader(campaign, advertiserInfo, findImage, signImage);
    }
}
