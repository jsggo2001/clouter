package com.mmm.clout.contractservice.contract.application.reader;

import com.mmm.clout.contractservice.contract.domain.ClouterInfo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class ClouterInfoReader {

    @Schema(description = "조회된 계약 클라우터 id")
    private Long clouterId;

    @Schema(description = "조회된 계약 클라우터 이름")
    private String clouterName;

    @Schema(description = "조회된 계약 클라우터 주소")
    private String clouterAddress;

    @Schema(description = "조회된 계약 클라우터 주민번호")
    private String residentRegistrationNumber;

    public ClouterInfoReader(ClouterInfo info) {
        this.clouterId = info.getClouterId();
        this.clouterName = info.getClouterName();
        this.clouterAddress = info.getClouterAddress();
        this.residentRegistrationNumber = info.getResidentRegistrationNumber();
    }
}
