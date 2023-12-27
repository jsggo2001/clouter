package com.mmm.clout.memberservice.advertiser.presentation.response;

import com.mmm.clout.memberservice.advertiser.domain.Advertiser;
import com.mmm.clout.memberservice.common.Role;
import com.mmm.clout.memberservice.common.entity.address.response.AddressResponse;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SelectAdrResponse {

    @Schema(description = "광고주 멤버 아이디")
    private Long advertiserId;

    @Schema(description = "광고주 유저 아이디")
    private String userId;

    @Schema(description = "광고주 유저 role (USER, ADMIN)")
    private Role role;

    @Schema(description = "광고주 별점 평균")
    private Long advertiserAvgStar;

    private AddressResponse addressInfo;

    private CompanyInfoResponse companyInfo;

    public SelectAdrResponse(Advertiser advertiser) {
        this.advertiserId = advertiser.getId();
        this.userId = advertiser.getUserId();
        this.role = advertiser.getRole();
        this.advertiserAvgStar = advertiser.getAvgScore();
        this.addressInfo = new AddressResponse(advertiser.getAddress());
        this.companyInfo = new CompanyInfoResponse(advertiser.getCompanyInfo());
    }

    public static SelectAdrResponse from(Advertiser advertiser) {
        SelectAdrResponse response = new SelectAdrResponse(advertiser);
        return response;
    }
}
