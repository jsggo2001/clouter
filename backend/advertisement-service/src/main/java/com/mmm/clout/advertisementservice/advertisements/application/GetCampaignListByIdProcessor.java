package com.mmm.clout.advertisementservice.advertisements.application;

import com.mmm.clout.advertisementservice.advertisements.application.reader.CampaignReader;
import com.mmm.clout.advertisementservice.advertisements.application.reader.FeignCampaignReader;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.advertisements.domain.repository.CampaignRepository;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.mmm.clout.advertisementservice.image.domain.Image;
import com.mmm.clout.advertisementservice.image.domain.repository.ImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
public class GetCampaignListByIdProcessor {

    private final CampaignRepository campaignRepository;
    private final ImageRepository imageRepository;


    @Transactional
    public List<FeignCampaignReader> execute(List<Long> adIdList) {
        List<Campaign> campaigns = campaignRepository.findByIdIn(adIdList);
        for (Campaign campaign : campaigns) {
            campaign.initialize();
        }

        List<Long> idList = campaigns.stream().map(v -> v.getId()).collect(Collectors.toList());

        Map<Long, List<Image>> imageMap = imageRepository.findByCampaignIdIn(idList).stream()
            .collect(Collectors.groupingBy(image -> image.getCampaign().getId()));

        return campaigns.stream()
            .map(v -> new FeignCampaignReader(v, imageMap.get(v.getId())))
            .collect(Collectors.toList());
    }
}
