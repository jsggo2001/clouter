package com.mmm.clout.memberservice.bookmark.presentation.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@AllArgsConstructor
@Getter
public class CampaignResponse {
    @Schema(description = "광고 캠페인 식별자")
    private Long campaignId;

    @Schema(description = "광고 플랫폼 리스트")
    private List<String> adPlatformList;

    @Schema(description = "광고비")
    private Long price;

    @Schema(description = "광고 캠페인 등록명/제품명")
    private String title;

    @Schema(description = "광고 카테고리")
    private String adCategory; // 광고 카테고리

    @Schema(description = "모집인원")
    private Integer numberOfRecruiter; // 모집인원

    @Schema(description = "신청인원")
    private Integer numberOfApplicants; // 신청인원

    @Schema(description = "채택 인원")
    private Integer numberOfSelectedMembers; // 채택 인원

    @Schema(description = "광고 등록자 (광고주) 고유 식별자 id")
    private Long registerId;

}
