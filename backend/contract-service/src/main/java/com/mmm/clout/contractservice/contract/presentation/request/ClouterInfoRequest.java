package com.mmm.clout.contractservice.contract.presentation.request;

import com.mmm.clout.contractservice.contract.application.command.ClouterInfoCommand;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@AllArgsConstructor
@Getter
public class ClouterInfoRequest {

    @Schema(description = "클라우터 id")
    @NotNull
    private Long clouterId;

    @Schema(description = "클라우터 이름")
    @NotBlank
    private String clouterName;

    @Schema(description = "계약에 명시될 클라우터 주소")
    @NotBlank
    private String clouterAddress;

    public ClouterInfoCommand toCommand() {
        return new ClouterInfoCommand(
                this.clouterId,
                this.clouterName,
                this.clouterAddress
        );
    }
}
