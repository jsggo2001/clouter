package com.mmm.clout.contractservice.contract.presentation.request;

import com.mmm.clout.contractservice.contract.application.command.CreateContractCommand;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.jetbrains.annotations.NotNull;

import javax.validation.constraints.NotBlank;

@AllArgsConstructor
@Getter
public class CreateContractRequest {

    @Schema(description = "계약건 명")
    @NotBlank
    private String name;

    @Schema(description = "신청 아이디")
    @NotNull
    private Long applyId;

    @Schema(description = "계약의 계약 금액")
    @NotNull
    private Long price;

    @Schema(description = "계약 게시 기간")
    @NotBlank
    private String postDeadline;

    @Schema(description = "계약 지속 기간")
    @NotBlank
    private String contractExpiration;

    @Schema(description = "계약 상세 수행 내역")
    @NotBlank
    private String contents;

    @Schema(description = "광고주 아이디")
    @NotNull
    private Long advertiserId;

    @Schema(description = "클라우터 아이디")
    @NotNull
    private Long clouterId;

    @Schema(description = "광고주 사인")
    @NotNull
    private String path;

    public CreateContractCommand toCommand() {
           return new CreateContractCommand(
                   this.name,
                   this.applyId,
                   this.price,
                   this.postDeadline,
                   this.contractExpiration,
                   this.contents,
                   this.clouterId,
                   this.advertiserId,
                   this.path
           );
    }
}
