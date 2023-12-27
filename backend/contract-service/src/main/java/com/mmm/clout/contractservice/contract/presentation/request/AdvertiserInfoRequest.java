package com.mmm.clout.contractservice.contract.presentation.request;

import com.mmm.clout.contractservice.contract.application.command.AdvertiserInfoCommand;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@AllArgsConstructor
@Getter
public class AdvertiserInfoRequest {

    @Schema(description = "회사 id")
    @NotNull
    private Long advertiserId;

    @Schema(description = "회사 대표 이름")
    @NotBlank
    private String representativeName;

    @Schema(description = "계약에 명시될 회사 주소")
    @NotBlank
    private String advertiserAddress;

    @Schema(description = "회사 이름")
    @NotBlank
    private String companyName;

    @Schema(description = "사업자 등록 번호")
    @NotBlank
    private String regNum;

    public AdvertiserInfoCommand toCommand() {
        return new AdvertiserInfoCommand(
                this.advertiserId,
                this.representativeName,
                this.advertiserAddress,
                this.companyName,
                this.regNum
        );
    }
}
