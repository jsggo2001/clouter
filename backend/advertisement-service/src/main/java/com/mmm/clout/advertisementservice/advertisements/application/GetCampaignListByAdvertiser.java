package com.mmm.clout.advertisementservice.advertisements.application;

import com.mmm.clout.advertisementservice.advertisements.application.reader.CampaignListReader;
import com.mmm.clout.advertisementservice.advertisements.application.reader.CampaignReader;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.advertisements.domain.repository.CampaignRepository;
import com.mmm.clout.advertisementservice.common.msa.info.AdvertiserInfo;
import com.mmm.clout.advertisementservice.common.msa.provider.MemberProvider;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.mmm.clout.advertisementservice.image.domain.AdvertiseSign;
import com.mmm.clout.advertisementservice.image.domain.Image;
import com.mmm.clout.advertisementservice.image.domain.repository.AdvertiseSignRepository;
import com.mmm.clout.advertisementservice.image.domain.repository.ImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
public class GetCampaignListByAdvertiser {

    private final CampaignRepository campaignRepository;
    private final MemberProvider memberProvider;
    private final ImageRepository imageRepository;
    private final AdvertiseSignRepository advertiseSignRepository;

    @Transactional
    public CampaignListReader execute(Long advertiserId, Pageable pageable) {
        AdvertiserInfo advertiserInfo = memberProvider.getAdvertiserInfoByMemberId(advertiserId);
        Page<Campaign> campainList =
            campaignRepository.getCampainListByAdvertiserId(advertiserId, pageable);
        for (Campaign campaign : campainList.getContent()) {
            campaign.initialize();
        }
        List<Long> idList = campainList.stream().map(v -> v.getId()).collect(Collectors.toList());

        Map<Long, List<Image>> imageMap = imageRepository.findByCampaignIdIn(idList).stream()
            .collect(Collectors.groupingBy(image -> image.getCampaign().getId()));

        Map<Long, AdvertiseSign> signMap = advertiseSignRepository.findByCampaignIdIn(idList)
            .stream().collect(Collectors.toMap(
            sign -> sign.getCampaign().getId(),
            sign -> sign));

        return new CampaignListReader(campainList, advertiserInfo, imageMap, signMap);
    }
}
