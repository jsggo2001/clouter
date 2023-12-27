package com.mmm.clout.advertisementservice.advertisements.persentation.response;

import com.mmm.clout.advertisementservice.common.msa.info.AdvertiserInfo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class AdvertiserResponse {

    @Schema(description = "광고주 고유 식별자 == memberId")
    private Long advertiserId; // memberId

    @Schema(description = "클라우트 앱 상에서의 아이디")
    private String userId; // 아이디

    @Schema(description = "유저 역할")
    private String role;

    @Schema(description = "광고주 별점 평균")
    private Long advertiserAvgStar;

    @Schema(description = "광고주 주소")
    private AddressResponse addressInfo;

    @Schema(description = "광고주 회사 정보")
    private CompanyResponse companyInfo;

    public static AdvertiserResponse from(AdvertiserInfo info) {
        return new AdvertiserResponse(
            info.getAdvertiserId(),
            info.getUserId(),
            info.getRole(),
            info.getAdvertiserAvgStar(),
            AddressResponse.from(
                info.getAddressInfo()
            ),
            CompanyResponse.from(
                info.getCompanyInfo()
            )
        );
    }


}
