package com.mmm.clout.contractservice.contract.application.command;

import com.mmm.clout.contractservice.contract.domain.AdvertiserInfo;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class AdvertiserInfoCommand {

    private Long advertiserId;

    private String representativeName;

    private String advertiserAddress;

    private String companyName;

    private String regNum;

    public AdvertiserInfo toValueType() {
        return new AdvertiserInfo(
                this.advertiserId,
                this.representativeName,
                this.advertiserAddress,
                this.companyName,
                this.regNum
        );
    }
}
