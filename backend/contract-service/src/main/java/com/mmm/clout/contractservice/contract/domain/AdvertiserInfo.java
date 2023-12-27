package com.mmm.clout.contractservice.contract.domain;

import com.mmm.clout.contractservice.contract.domain.info.SelectAdrInfo;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;

@Embeddable
@AllArgsConstructor
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class AdvertiserInfo {

    private Long advertiserId;

    private String representativeName;

    private String advertiserAddress;

    private String companyName;

    private String regNum;

    public AdvertiserInfo(SelectAdrInfo info) {
        this.advertiserId = info.getAdvertiserId();
        this.representativeName = info.getCompanyInfo().getCeoName();
        this.advertiserAddress = info.getAddressInfo().getMainAddress() + " " + info.getAddressInfo().getDetailAddress();
        this.companyName = info.getCompanyInfo().getCompanyName();
        this.regNum = info.getCompanyInfo().getRegNum();
    }
}
