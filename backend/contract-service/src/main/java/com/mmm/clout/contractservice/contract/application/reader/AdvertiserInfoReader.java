package com.mmm.clout.contractservice.contract.application.reader;

import com.mmm.clout.contractservice.contract.domain.AdvertiserInfo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class AdvertiserInfoReader {

    @Schema(description = "조회된 계약 회사 id")
    private Long advertiserId;

    @Schema(description = "조회된 계약 회사 대표 이름")
    private String representativeName;

    @Schema(description = "조회된 계약 회사 주소")
    private String advertiserAddress;

    @Schema(description = "조회된 계약 회사 이름")
    private String companyName;

    @Schema(description = "조회된 계약 회사 사업자 등록번호")
    private String regNum;

    public AdvertiserInfoReader(AdvertiserInfo info) {
        this.advertiserId = info.getAdvertiserId();
        this.representativeName = info.getRepresentativeName();
        this.advertiserAddress = info.getAdvertiserAddress();
        this.companyName = info.getCompanyName();
        this.regNum = info.getRegNum();
    }
}
