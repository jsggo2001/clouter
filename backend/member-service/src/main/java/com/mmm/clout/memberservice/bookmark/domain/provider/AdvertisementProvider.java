package com.mmm.clout.memberservice.bookmark.domain.provider;

import com.mmm.clout.memberservice.bookmark.domain.info.CampaignInfo;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

public interface AdvertisementProvider {

    public ResponseEntity<List<CampaignInfo>> getCampaignListById(@RequestParam(name = "adId") List<Long> adIdList);

}
