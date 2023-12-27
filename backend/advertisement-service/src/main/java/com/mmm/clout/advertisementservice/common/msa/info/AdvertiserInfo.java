package com.mmm.clout.advertisementservice.common.msa.info;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;
@JsonInclude(Include.NON_NULL)
@Getter
@AllArgsConstructor
public class AdvertiserInfo {

    private Long advertiserId; // memberId

    private String userId; // 아이디

    private String role;

    private Long advertiserAvgStar;

    private AddressInfo addressInfo;

    private CompanyInfo companyInfo;

}
