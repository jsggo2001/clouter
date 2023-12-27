package com.mmm.clout.advertisementservice.apply.presentation.response;

import com.mmm.clout.advertisementservice.apply.domain.Apply;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CreateApplyResponse {

    private Long createdApplyId; // 신청 id

    private Long appliedAdvertisementId; // 신청된 광고 캠페인 id

    private Integer totalNumberOfApplicants; // 현재 최종 신청자 수


    public static CreateApplyResponse from(Apply apply) {
        return new CreateApplyResponse(
            apply.getId(),
            apply.getCampaign().getId(),
            apply.getCampaign().getNumberOfApplicants()
        );
    }
}
