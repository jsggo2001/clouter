package com.mmm.clout.contractservice.contract.presentation.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@AllArgsConstructor
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UpdateRRNContractRequest {

    @Schema(description = "클라우터 주민번호", defaultValue = "991212-111111")
    @NotBlank
    private String residentRegistrationNumber;
}
