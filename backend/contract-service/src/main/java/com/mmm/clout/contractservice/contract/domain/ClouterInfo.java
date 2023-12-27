package com.mmm.clout.contractservice.contract.domain;

import com.mmm.clout.contractservice.contract.domain.info.SelectClrInfo;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;

@Embeddable
@AllArgsConstructor
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ClouterInfo {

    private Long clouterId;

    private String clouterName;

    private String clouterAddress;

    private String residentRegistrationNumber;

    public ClouterInfo(SelectClrInfo info) {
        this.clouterId = info.getClouterId();
        this.clouterName = info.getName();
        this.clouterAddress = info.getAddress().getMainAddress() + " " + info.getAddress().getDetailAddress();
        this.residentRegistrationNumber = "";
    }

    public ClouterInfo updateResidentRegistrationNumber(String residentRegistrationNumber) {
        this.residentRegistrationNumber = residentRegistrationNumber;
        return this;
    }

}
