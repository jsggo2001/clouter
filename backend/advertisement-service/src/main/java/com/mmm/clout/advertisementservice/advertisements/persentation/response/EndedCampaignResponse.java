package com.mmm.clout.advertisementservice.advertisements.persentation.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class EndedCampaignResponse {

    @Schema(description = "모집 종료된 캠페인 id")
    private Long endedCampaignId;

    public static EndedCampaignResponse from(Long endedCampaignId) {
        return new EndedCampaignResponse(endedCampaignId);
    }
}
