package com.mmm.clout.advertisementservice.apply.presentation.response;

import com.mmm.clout.advertisementservice.apply.application.reader.ApplyListByClouterReader;
import com.mmm.clout.advertisementservice.apply.domain.Apply;
import java.util.ArrayList;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class GetAllByStatusResponse {

    private List<GetApplyByStatusResponse> applyList;


    public static GetAllByStatusResponse from(List<ApplyListByClouterReader> readerList) {
        List<GetApplyByStatusResponse> responseList = new ArrayList<>();
        for (ApplyListByClouterReader r :readerList) {
            Apply apply = r.getApply();
            responseList.add(
                new GetApplyByStatusResponse(
                    apply.getId(),
                    apply.getApplyStatus(),
                    apply.getCampaign().getAdCategory(),
                    apply.getCampaign().getTitle(),
                    apply.getCampaign().getPrice(),
                    apply.getCampaign().getNumberOfSelectedMembers(),
                    apply.getCampaign().getNumberOfRecruiter(),
                    apply.getCampaign().getNumberOfApplicants(),
                    r.getCompanyName(),
                    r.getAdvertiserAvgStar(),
                        r.getCampaignId(),
                        r.getAdPlatformList()
                )
            );
        }
        return new GetAllByStatusResponse(responseList);
    }
}
