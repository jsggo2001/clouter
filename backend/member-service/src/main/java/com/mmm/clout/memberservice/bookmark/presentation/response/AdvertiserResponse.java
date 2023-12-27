package com.mmm.clout.memberservice.bookmark.presentation.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class AdvertiserResponse {

    @Schema(description = "광고주 고유 식별자 == memberId")
    private Long advertiserId; // memberId

    @Schema(description = "광고주 별점 평균")
    private Long advertiserAvgStar;

    @Schema(description = "광고주 회사 정보")
    private CompanyResponse companyInfo;
}

