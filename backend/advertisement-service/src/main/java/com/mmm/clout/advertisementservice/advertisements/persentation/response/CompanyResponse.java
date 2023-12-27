package com.mmm.clout.advertisementservice.advertisements.persentation.response;

import com.mmm.clout.advertisementservice.common.msa.info.CompanyInfo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CompanyResponse  {

    @Schema(description = "회사명")
    private String companyName;

    @Schema(description = "사업자 등록 번호")
    private String regNum;

    @Schema(description = "담당자명")
    private String managerName;

    @Schema(description = "담당자 핸드폰번호")
    private String managerPhoneNumber;


    public static CompanyResponse from(CompanyInfo info) {
        return new CompanyResponse(
            info.getCompanyName(),
            info.getRegNum(),
            info.getManagerName(),
            info.getManagerPhoneNumber()
        );
    }
}
