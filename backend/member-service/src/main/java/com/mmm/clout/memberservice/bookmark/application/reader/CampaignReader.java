package com.mmm.clout.memberservice.bookmark.application.reader;

import com.mmm.clout.memberservice.advertiser.domain.Advertiser;
import com.mmm.clout.memberservice.bookmark.domain.info.CampaignInfo;
import com.mmm.clout.memberservice.bookmark.presentation.response.AdvertiserResponse;
import com.mmm.clout.memberservice.bookmark.presentation.response.CampaignResponse;
import com.mmm.clout.memberservice.bookmark.presentation.response.CompanyResponse;
import com.mmm.clout.memberservice.image.presentation.ImageResponse;
import lombok.Getter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Getter
public class CampaignReader {

    private CampaignResponse campaign;

    private AdvertiserResponse advertiserInfo;

    private List<ImageResponse> imageList;//이미지 경로

    public CampaignReader(CampaignInfo info, Advertiser advertiser) {
        this.campaign = new CampaignResponse(
            info.getCampaignId(),
            info.getAdPlatformList(),
            info.getPrice(),
            info.getTitle(),
            info.getAdCategory(),
            info.getNumberOfRecruiter(),
            info.getNumberOfApplicants(),
            info.getNumberOfSelectedMembers(),
            info.getRegisterId()
            );
        this.advertiserInfo = new AdvertiserResponse(
            advertiser.getId(),
            advertiser.getAvgScore(),
            new CompanyResponse(advertiser.getCompanyInfo().getCompanyName())
        );
        this.imageList = info.getImageList();
    }
}
