package com.mmm.clout.advertisementservice.advertisements.persentation.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.mmm.clout.advertisementservice.advertisements.application.reader.FeignCampaignReader;
import com.mmm.clout.advertisementservice.advertisements.domain.AdCategory;
import com.mmm.clout.advertisementservice.advertisements.domain.AdPlatform;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.image.presentation.ImageResponse;
import io.swagger.v3.oas.annotations.media.Schema;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import lombok.AllArgsConstructor;
import lombok.Getter;

@JsonInclude(Include.NON_NULL)
@Getter
@AllArgsConstructor
public class CampaignResponse {

    @Schema(description = "광고 캠페인 식별자")
    private Long campaignId;

    @Schema(description = "광고 플랫폼 리스트")
    private List<AdPlatform> adPlatformList;

    @Schema(description = "광고비")
    private Long price;

    @Schema(description = "광고 상세 설명")
    private String details;

    @Schema(description = "광고 삭제 여부")
    private LocalDateTime deletedAt;

    @Schema(description = "광고 캠페인 등록명/제품명")
    private String title;

    @Schema(description = "광고 카테고리")
    private AdCategory adCategory; // 광고 카테고리

    @Schema(description = "광고비 협의 여부")
    private Boolean isPriceChangeable; // 광고비 협의 여부

    @Schema(description = "배송 여부")
    private Boolean isDeliveryRequired; // 배송 여부

    @Schema(description = "모집인원")
    private Integer numberOfRecruiter; // 모집인원

    @Schema(description = "신청인원")
    private Integer numberOfApplicants; // 신청인원

    @Schema(description = "채택 인원")
    private Integer numberOfSelectedMembers; // 채택 인원

    @Schema(description = "제공 내역 설명")
    private String offeringDetails; // 제공 내역 설명

    @Schema(description = "판매처 링크 (선택사항)")
    private String sellingLink; // 판매처 링크 (선택사항)

    @Schema(description = "모집 시작 날짜")
    private LocalDate applyStartDate; // 모집 시작 날짜

    @Schema(description = "모집 종료 날짜")
    private LocalDate applyEndDate; // 모집 종료 날짜

    @Schema(description = "최소 클라우터 나이")
    private Integer minClouterAge; // 최소 클라우터 나이

    @Schema(description = "최대 클라우터 나이")
    private Integer maxClouterAge; // 최대 클라우터 나이

    @Schema(description = "최소 팔로워 수")
    private Integer minFollower; // 최소 팔로워 수

    @Schema(description = "모집 종료 여부")
    private Boolean isEnded; // 모집 종료 여부

    @Schema(description = "광고 등록자 (광고주) 고유 식별자 id")
    private Long registerId;

    private List<ImageResponse> imageList;

    public static CampaignResponse from(Campaign campaign) {
        return new CampaignResponse(
            campaign.getId(),
            campaign.getAdPlatformList(),
            campaign.getPrice(),
            campaign.getDetails(),
            campaign.getDeletedAt(),
            campaign.getTitle(),
            campaign.getAdCategory(),
            campaign.getIsPriceChangeable(),
            campaign.getIsDeliveryRequired(),
            campaign.getNumberOfRecruiter(),
            campaign.getNumberOfApplicants(),
            campaign.getNumberOfSelectedMembers(),
            campaign.getOfferingDetails(),
            campaign.getSellingLink(),
            campaign.getApplyStartDate(),
            campaign.getApplyEndDate(),
            campaign.getMinClouterAge(),
            campaign.getMaxClouterAge(),
            campaign.getMinFollower(),
            campaign.getIsEnded(),
            campaign.getRegisterId(),
            null
        );
    }
    public static CampaignResponse from(FeignCampaignReader reader) {
        return new CampaignResponse(
            reader.getCampaign().getId(),
            reader.getCampaign().getAdPlatformList(),
            reader.getCampaign().getPrice(),
            reader.getCampaign().getDetails(),
            reader.getCampaign().getDeletedAt(),
            reader.getCampaign().getTitle(),
            reader.getCampaign().getAdCategory(),
            reader.getCampaign().getIsPriceChangeable(),
            reader.getCampaign().getIsDeliveryRequired(),
            reader.getCampaign().getNumberOfRecruiter(),
            reader.getCampaign().getNumberOfApplicants(),
            reader.getCampaign().getNumberOfSelectedMembers(),
            reader.getCampaign().getOfferingDetails(),
            reader.getCampaign().getSellingLink(),
            reader.getCampaign().getApplyStartDate(),
            reader.getCampaign().getApplyEndDate(),
            reader.getCampaign().getMinClouterAge(),
            reader.getCampaign().getMaxClouterAge(),
            reader.getCampaign().getMinFollower(),
            reader.getCampaign().getIsEnded(),
            reader.getCampaign().getRegisterId(),
            reader.getImageList().stream().map(v -> new ImageResponse(v)).collect(Collectors.toList())
        );
    }
}
