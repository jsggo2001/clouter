package com.mmm.clout.advertisementservice.advertisements.persentation.response;

import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Schema(description = "광고 캠페인 등록 response")
public class CreateCampaignResponse {

    @Schema(description = "생성된 광고 캠페인 id")
    private Long createdAdId;


    public static CreateCampaignResponse from(Campaign campaign) {
        return new CreateCampaignResponse(campaign.getId());
    }
}
