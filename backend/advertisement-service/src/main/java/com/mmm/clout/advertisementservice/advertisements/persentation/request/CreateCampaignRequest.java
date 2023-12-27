package com.mmm.clout.advertisementservice.advertisements.persentation.request;

import com.mmm.clout.advertisementservice.advertisements.application.command.CreateCampaignCommand;
import com.mmm.clout.advertisementservice.advertisements.domain.AdCategory;
import com.mmm.clout.advertisementservice.advertisements.domain.AdPlatform;
import com.mmm.clout.advertisementservice.advertisements.domain.Region;
import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CreateCampaignRequest {

    @NotNull
    @Schema(description = "광고 등록자 id (광고주 id)")
    private Long registerId;

    @NotNull
    @Schema(description = "광고 카테고리")
    private AdCategory adCategory;

    @NotBlank
    @Size(min = 1, max = 50)
    @Schema(description = "광고 제목")
    private String title;

    @NotNull
    @Min(1)
    @Max(100)
    @Schema(description = "모집 인원")
    private Integer numberOfRecruiter;

    @NotNull
    @Schema(description = "광고비 협의 여부 체크")
    private Boolean isPriceChangeable;

    @NotNull
    @Schema(description = "광고비 (협의하더라도, 0원으로 보내주기)")
    private Long price;

    @NotBlank
    @Size(max = 500)
    @Schema(description = "제공 내역 설명 (제공할 물품 또는 서비스)")
    private String offeringDetails;

    @Schema(description = "판매처 링크")
    private String sellingLink;

    @NotNull
    @Schema(description = "제품 배송 여부 체크 ")
    private Boolean isDeliveryRequired;

    @NotBlank
    @Size(max = 800)
    @Schema(description = "제품 또는 서비스 상세 내역")
    private String details;

    @NotNull
    @Size(min=1, message="희망 플랫폼 리스트는 최소한 한 개의 요소를 포함해야 합니다.")
    @Schema(description = "광고 희망 플랫폼 리스트")
    private List<AdPlatform> adPlatformList;

    @NotNull
    @Min(0)
    @Max(100)
    @Schema(description = "희망 클라우터 최소 나이")
    private Integer minClouterAge;

    @NotNull
    @Min(0)
    @Max(100)
    @Schema(description = "희망 클라우터 최대 나이")
    private Integer maxClouterAge;

    @NotNull
    @Schema(description = "희망 최소 팔로워 수")
    private Integer minFollower;

    @NotNull
    @Size(min=1, message="희망 지역 리스트는 최소한 한 개의 요소를 포함해야 합니다.")
    @Schema(description = "지역 선택 (다중선택 가능)")
    private List<Region> regionList;


    public CreateCampaignCommand toCommand() {
        return new CreateCampaignCommand(
            this.registerId,
            this.adCategory,
            this.title,
            this.numberOfRecruiter,
            this.isPriceChangeable,
            this.price,
            this.offeringDetails,
            this.sellingLink,
            this.isDeliveryRequired,
            this.details,
            this.adPlatformList,
            this.minClouterAge,
            this.maxClouterAge,
            this.minFollower,
            this.regionList
        );
    }
}
