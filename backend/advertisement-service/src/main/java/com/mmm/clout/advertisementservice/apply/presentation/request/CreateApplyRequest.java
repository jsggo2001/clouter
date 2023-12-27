package com.mmm.clout.advertisementservice.apply.presentation.request;

import com.mmm.clout.advertisementservice.apply.application.command.CreateApplyCommand;
import io.swagger.v3.oas.annotations.media.Schema;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CreateApplyRequest {

    @NotNull
    @Schema(description = "신청할 광고 캠페인 id")
    private Long advertisementId;

    @NotNull
    @Schema(description = "신청하는 클라우터 id")
    private Long clouterId;

    @NotBlank
    @Size(min = 1, max = 300)
    @Schema(description = "신청 한마디")
    private String applyMessage;

    @NotNull
    @Schema(description = "제안하는 광고비")
    private Long hopeAdFee;


    public CreateApplyCommand toCommand() {
        return new CreateApplyCommand(
            this.advertisementId,
            this.clouterId,
            this.applyMessage,
            this.hopeAdFee
        );
    }

}
