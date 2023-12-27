package com.mmm.clout.advertisementservice.advertisements.persentation.response;

import com.mmm.clout.advertisementservice.advertisements.application.reader.CampaignListReader;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.common.msa.info.AdvertiserInfo;
import java.util.List;
import java.util.stream.Collectors;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.data.domain.Page;

@Getter
@AllArgsConstructor
public class GetCampainListByAdvertiserResponse {

    private List<CampaignResponse> campaignList;

    private AdvertiserResponse advertiserInfo;

    public static GetCampainListByAdvertiserResponse from(CampaignListReader reader) {
        Page<Campaign> campaigns = reader.getCampaignList();
        AdvertiserInfo advertiser = reader.getAdvertiserInfo();
        return new GetCampainListByAdvertiserResponse(
            campaigns.stream().map(CampaignResponse::from).collect(Collectors.toList()),
            AdvertiserResponse.from(advertiser)
        );
    }
}
