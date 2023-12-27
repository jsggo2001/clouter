package com.mmm.clout.contractservice.contract.domain.info;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CompanyInfo {

    private String companyName;

    private String regNum;

    private String ceoName;

    private String managerName;

    private String managerPhoneNumber;

//    public CompanyInfoResponse(CompanyInfo companyInfo) {
//        this.companyName = companyInfo.getCompanyName();
//        this.regNum = companyInfo.getRegNum();
//        this.ceoName = companyInfo.getCeoName();
//        this.managerName = companyInfo.getManagerName();
//        this.managerPhoneNumber = companyInfo.getManagerPhoneNumber();
//    }
}
