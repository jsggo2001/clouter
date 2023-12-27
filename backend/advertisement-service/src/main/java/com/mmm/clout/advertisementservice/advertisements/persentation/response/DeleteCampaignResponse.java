package com.mmm.clout.advertisementservice.advertisements.persentation.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class DeleteCampaignResponse {

    @Schema(description = "삭제된 광고 id")
    private Long deletedAdvertisementId;

    public static DeleteCampaignResponse from(Long advertisementId) {
        return new DeleteCampaignResponse(advertisementId);
    }
}
