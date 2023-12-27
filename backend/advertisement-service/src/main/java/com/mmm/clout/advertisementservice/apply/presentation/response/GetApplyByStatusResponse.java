package com.mmm.clout.advertisementservice.apply.presentation.response;

import com.mmm.clout.advertisementservice.advertisements.domain.AdCategory;
import com.mmm.clout.advertisementservice.advertisements.domain.AdPlatform;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.apply.application.reader.ApplyListByClouterReader;
import com.mmm.clout.advertisementservice.apply.domain.Apply;
import com.mmm.clout.advertisementservice.apply.domain.Apply.ApplyStatus;
import io.swagger.v3.oas.annotations.media.Schema;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class GetApplyByStatusResponse {

    @Schema(description = "신청 고유 식별자 (id)")
    private Long applyId;

    @Schema(description = "신청 상태")
    private ApplyStatus applyStatus;

    @Schema(description = "카테고리")
    private AdCategory adCategory;

    @Schema(description = "캠페인 등록명(제목)")
    private String title;

    @Schema(description = "광고비")
    private Long price;

    @Schema(description = "채택인원")
    private Integer numberOfSelectedMembers;

    @Schema(description = "모집인원")
    private Integer numberOfRecruiter;

    @Schema(description = "신청인원")
    private Integer numberOfApplicants;

//    private List<ImageResponse> imageList;

    @Schema(description = "업체명")
    private String companyName;

    @Schema(description = "광고주 평균 별점")
    private Long advertiserAvgStar;

    @Schema(description = "캠페인 아이디")
    private Long campaignId;

    @Schema(description = "캠페인 희망 플랫폼 리스트")
    private List<AdPlatform> adPlatformList;


    public static GetApplyByStatusResponse from(ApplyListByClouterReader reader) {
        Apply apply = reader.getApply();
        Campaign campaign = apply.getCampaign();
        return new GetApplyByStatusResponse(
                apply.getId(),
                apply.getApplyStatus(),
                campaign.getAdCategory(),
                campaign.getTitle(),
                campaign.getPrice(),
                campaign.getNumberOfSelectedMembers(),
                campaign.getNumberOfRecruiter(),
                campaign.getNumberOfApplicants(),
                reader.getCompanyName(),
                reader.getAdvertiserAvgStar(),
                reader.getCampaignId(),
                reader.getAdPlatformList()
        );
    }
}
