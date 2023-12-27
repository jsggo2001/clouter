package com.mmm.clout.advertisementservice.advertisements.persentation.response;

import com.mmm.clout.advertisementservice.advertisements.domain.AdCategory;
import com.mmm.clout.advertisementservice.advertisements.domain.AdPlatform;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.advertisements.domain.Region;
import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class UpdateCampaignResponse {

    @Schema(description = "수정된 광고 id")
    private Long updatedAdvertisementId;

    @Schema(description = "광고 카테고리")
    private AdCategory adCategory;

    @Schema(description = "광고 제목")
    private String title;

    @Schema(description = "모집 인원")
    private Integer numberOfRecruiter;

    @Schema(description = "광고비 협의 여부 체크")
    private Boolean isPriceChangeable;

    @Schema(description = "광고비 (협의하더라도, 0원으로 보내주기)")
    private Long price;

    @Schema(description = "제공 내역 설명 (제공할 물품 또는 서비스)")
    private String offeringDetails;

    @Schema(description = "판매처 링크")
    private String sellingLink;

    @Schema(description = "제품 배송 여부 체크 ")
    private Boolean isDeliveryRequired;

    @Schema(description = "제품 또는 서비스 상세 내역")
    private String details;

    @Schema(description = "광고 희망 플랫폼 리스트")
    private List<AdPlatform> adPlatformList;

    @Schema(description = "희망 클라우터 최소 나이")
    private Integer minClouterAge;

    @Schema(description = "희망 클라우터 최대 나이")
    private Integer maxClouterAge;

    @Schema(description = "희망 최소 팔로워 수")
    private Integer minFollower;

    @Schema(description = "지역 선택 (다중선택 가능)")
    private List<Region> regionList;


    public static UpdateCampaignResponse from(Campaign updatedCampaign) {
        return new UpdateCampaignResponse(
            updatedCampaign.getId(),
            updatedCampaign.getAdCategory(),
            updatedCampaign.getTitle(),
            updatedCampaign.getNumberOfRecruiter(),
            updatedCampaign.getIsPriceChangeable(),
            updatedCampaign.getPrice(),
            updatedCampaign.getOfferingDetails(),
            updatedCampaign.getSellingLink(),
            updatedCampaign.getIsDeliveryRequired(),
            updatedCampaign.getDetails(),
            updatedCampaign.getAdPlatformList(),
            updatedCampaign.getMinClouterAge(),
            updatedCampaign.getMaxClouterAge(),
            updatedCampaign.getMinFollower(),
            updatedCampaign.getRegionList()
        );
    }
}
