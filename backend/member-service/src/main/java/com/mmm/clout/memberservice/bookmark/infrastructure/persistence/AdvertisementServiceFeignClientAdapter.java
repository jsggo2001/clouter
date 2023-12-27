package com.mmm.clout.memberservice.bookmark.infrastructure.persistence;

import com.mmm.clout.memberservice.bookmark.domain.info.CampaignInfo;
import com.mmm.clout.memberservice.bookmark.domain.provider.AdvertisementProvider;
import com.mmm.clout.memberservice.bookmark.infrastructure.persistence.feign.AdvertisementFeignClient;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@RequiredArgsConstructor
public class AdvertisementServiceFeignClientAdapter implements AdvertisementProvider {

    private final AdvertisementFeignClient advertisementFeignClient;

    @Override
    public ResponseEntity<List<CampaignInfo>> getCampaignListById(List<Long> adIdList) {
        return advertisementFeignClient.getCampaignListById(adIdList);
    }
}
