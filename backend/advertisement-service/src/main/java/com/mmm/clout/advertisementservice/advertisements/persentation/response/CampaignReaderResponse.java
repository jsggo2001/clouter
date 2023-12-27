package com.mmm.clout.advertisementservice.advertisements.persentation.response;

import com.mmm.clout.advertisementservice.advertisements.application.reader.CampaignReader;
import com.mmm.clout.advertisementservice.image.domain.AdvertiseSign;
import com.mmm.clout.advertisementservice.image.domain.Image;
import com.mmm.clout.advertisementservice.image.presentation.AdvertiseSIgnResponse;
import com.mmm.clout.advertisementservice.image.presentation.ImageResponse;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@AllArgsConstructor
public class CampaignReaderResponse {

    private CampaignResponse campaign;
    private AdvertiserResponse advertiserInfo;
    private List<ImageResponse> imageList;
    private AdvertiseSIgnResponse signImage;


    public static CampaignReaderResponse from(CampaignReader result) {
        return new CampaignReaderResponse(
            CampaignResponse.from(result.getCampaign()),
            AdvertiserResponse.from(result.getAdvertiserInfo()),
            result.getImageList().stream().map(v -> new ImageResponse(v)).collect(Collectors.toList()),
            new AdvertiseSIgnResponse(result.getSignImage())
        );
    }
}
