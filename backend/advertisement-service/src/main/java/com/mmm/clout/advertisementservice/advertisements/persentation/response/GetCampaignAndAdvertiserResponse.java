package com.mmm.clout.advertisementservice.advertisements.persentation.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.mmm.clout.advertisementservice.advertisements.application.reader.CampaignReader;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.common.msa.info.AdvertiserInfo;
import com.mmm.clout.advertisementservice.image.presentation.AdvertiseSIgnResponse;
import com.mmm.clout.advertisementservice.image.presentation.ImageResponse;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;

@JsonInclude(Include.NON_NULL)
@Getter
@AllArgsConstructor
public class GetCampaignAndAdvertiserResponse {

    private CampaignResponse campaignInfo;

    private AdvertiserResponse advertiserInfo;

    private List<ImageResponse> imageList;

    private AdvertiseSIgnResponse advertiseSignResponse;

    public static GetCampaignAndAdvertiserResponse from(CampaignReader reader) {
        Campaign campaign = reader.getCampaign();
        AdvertiserInfo advertiser = reader.getAdvertiserInfo();

        return new GetCampaignAndAdvertiserResponse(
            CampaignResponse.from(campaign),
            AdvertiserResponse.from(advertiser),
            reader.getImageList().stream().map(v -> new ImageResponse(v)).collect(Collectors.toList()),
            new AdvertiseSIgnResponse(reader.getSignImage())
        );
    }
}

