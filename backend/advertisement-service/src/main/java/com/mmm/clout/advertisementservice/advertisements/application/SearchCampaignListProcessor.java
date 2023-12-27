package com.mmm.clout.advertisementservice.advertisements.application;

import com.mmm.clout.advertisementservice.advertisements.application.command.SearchCondition;
import com.mmm.clout.advertisementservice.advertisements.application.reader.CampaignReader;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.advertisements.domain.repository.CampaignRepository;
import com.mmm.clout.advertisementservice.common.msa.provider.MemberProvider;
import com.mmm.clout.advertisementservice.image.domain.AdvertiseSign;
import com.mmm.clout.advertisementservice.image.domain.Image;
import com.mmm.clout.advertisementservice.image.domain.repository.AdvertiseSignRepository;
import com.mmm.clout.advertisementservice.image.domain.repository.ImageRepository;
import com.querydsl.jpa.impl.JPAQuery;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.support.PageableExecutionUtils;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
public class SearchCampaignListProcessor {

    private final CampaignRepository campaignRepository;
    private final MemberProvider memberProvider;
    private final ImageRepository imageRepository;
    private final AdvertiseSignRepository advertiseSignRepository;

    @Transactional
    public Page<CampaignReader> execute(
        Pageable pageable,
        SearchCondition condition
    ) {
        List<Campaign> searchResult = campaignRepository.search(condition, pageable);
        JPAQuery<Campaign> countQuery = campaignRepository.getSearchCountQuery(condition);

        List<Long> idList = searchResult.stream().map(v -> v.getId()).collect(Collectors.toList());

        List<Image> imageList = imageRepository.findByCampaignIdIn(idList);
        Map<Long, List<Image>> imageMap = imageList.stream()
            .collect(Collectors.groupingBy(image -> image.getCampaign().getId()));

        List<AdvertiseSign> signList = advertiseSignRepository.findByCampaignIdIn(idList);
        Map<Long, AdvertiseSign> signMap = signList.stream().collect(Collectors.toMap(
            sign -> sign.getCampaign().getId(),
            sign -> sign));

        List<CampaignReader> content = searchResult.stream().map(
            campaign -> new CampaignReader(
                campaign.initialize(),
                memberProvider.getAdvertiserInfoByMemberId(campaign.getAdvertiserId()),
                imageMap.get(campaign.getId()),
                signMap.get(campaign.getId())
            )
        ).collect(Collectors.toList());

        return PageableExecutionUtils.getPage(content, pageable, countQuery::fetchCount);
    }


}
