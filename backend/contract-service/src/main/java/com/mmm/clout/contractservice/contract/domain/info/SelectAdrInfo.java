package com.mmm.clout.contractservice.contract.domain.info;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SelectAdrInfo {

    private Long advertiserId;

    private String userId;

    private Long totalPoint;

    private String role;

    private Long advertiserAvgStar;

    private AddressInfo addressInfo;

    private CompanyInfo companyInfo;


//    public SelectAdrResponse(Advertiser advertiser) {
//        this.advertiserId = advertiser.getId();
//        this.userId = advertiser.getUserId();
//        this.totalPoint = advertiser.getTotalPoint();
//        this.role = advertiser.getRole();
//        this.advertiserAvgStar = advertiser.getAvgScore();
//        this.addressInfo = new AddressResponse(advertiser.getAddress());
//        this.companyInfo = new CompanyInfoResponse(advertiser.getCompanyInfo());
//    }
//
//    public static SelectAdrResponse from(Advertiser advertiser) {
//        SelectAdrResponse response = new SelectAdrResponse(advertiser);
//        return response;
//    }
}

