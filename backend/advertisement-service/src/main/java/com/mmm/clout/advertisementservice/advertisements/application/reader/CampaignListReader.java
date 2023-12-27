package com.mmm.clout.advertisementservice.advertisements.application.reader;

import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.common.msa.info.AdvertiserInfo;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.mmm.clout.advertisementservice.image.domain.AdvertiseSign;
import com.mmm.clout.advertisementservice.image.domain.Image;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.data.domain.Page;

@Getter
@AllArgsConstructor
public class CampaignListReader {

    private Page<Campaign> campaignList;
    private AdvertiserInfo advertiserInfo;
    private Map<Long, List<Image>> imageMap;
    private Map<Long, AdvertiseSign> signMap;

}
