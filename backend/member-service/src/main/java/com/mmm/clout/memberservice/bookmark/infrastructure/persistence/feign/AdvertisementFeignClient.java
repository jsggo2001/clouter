package com.mmm.clout.memberservice.bookmark.infrastructure.persistence.feign;

import com.mmm.clout.memberservice.bookmark.domain.info.CampaignInfo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@FeignClient("advertisement-service")
public interface AdvertisementFeignClient {

    @GetMapping("/v1/advertisements/ads")
    public ResponseEntity<List<CampaignInfo>> getCampaignListById(
        @RequestParam(name = "adId") List<Long> adIdList
    );
}
