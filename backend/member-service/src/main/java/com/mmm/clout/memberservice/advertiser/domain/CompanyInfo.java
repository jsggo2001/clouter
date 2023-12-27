package com.mmm.clout.memberservice.advertiser.domain;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
@Getter
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class CompanyInfo {

    @Column(length = 30)
    private String companyName;

    private String regNum;

    @Column(length = 15)
    private String ceoName;

    @Column(length = 20)
    private String managerName;

    @Column(length = 30, unique = true)
    private String managerPhoneNumber;
}
