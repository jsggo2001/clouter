package com.mmm.clout.advertisementservice.advertisements.application;

import com.mmm.clout.advertisementservice.advertisements.application.reader.CampaignReader;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.advertisements.domain.repository.CampaignRepository;
import com.mmm.clout.advertisementservice.common.msa.provider.MemberProvider;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.mmm.clout.advertisementservice.image.domain.AdvertiseSign;
import com.mmm.clout.advertisementservice.image.domain.Image;
import com.mmm.clout.advertisementservice.image.domain.repository.AdvertiseSignRepository;
import com.mmm.clout.advertisementservice.image.domain.repository.ImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
public class GetTop10CampaignListProcessor {

    private final CampaignRepository campaignRepository;
    private final MemberProvider memberProvider;
    private final ImageRepository imageRepository;
    private final AdvertiseSignRepository advertiseSignRepository;

    @Transactional
    public List<CampaignReader> execute() {
        List<Campaign> top10List = campaignRepository.getTop10List();
        List<Long> advertisementIdList = top10List.stream().map(v -> v.getId()).collect(Collectors.toList());

        List<Image> imageList = imageRepository.findByCampaignIdIn(advertisementIdList);
        Map<Long, List<Image>> imageMap = imageList.stream()
            .collect(Collectors.groupingBy(image -> image.getCampaign().getId()));

        List<AdvertiseSign> signList = advertiseSignRepository.findByCampaignIdIn(advertisementIdList);
        Map<Long, AdvertiseSign> signMap = signList.stream().collect(Collectors.toMap(
            sign -> sign.getCampaign().getId(),
            sign -> sign));

        return top10List.stream().map(
            campaign -> new CampaignReader(
                campaign.initialize(),
                memberProvider.getAdvertiserInfoByMemberId(campaign.getAdvertiserId()),
                imageMap.get(campaign.getId()),
                signMap.get(campaign.getId())
            )
        ).collect(Collectors.toList());
    }
}
