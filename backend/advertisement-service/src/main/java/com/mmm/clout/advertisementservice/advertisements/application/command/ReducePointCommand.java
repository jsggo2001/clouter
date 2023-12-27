package com.mmm.clout.advertisementservice.advertisements.application.command;

import com.mmm.clout.advertisementservice.advertisements.infrastructure.constant.CampaignConstant;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Getter
@AllArgsConstructor
public class ReducePointCommand {

    @Schema(description = "멤버 고유 식별자 (id)")
    @NotNull
    private Long memberId;

    @Schema(description = "차감/사용할 포인트")
    @NotNull
    private Long reducingPoint;

    @Schema(description = "포인트 종류 (CONTRACT, CANCEL_CONTRACT, CREATE_CAMPAIGN)")
    @NotBlank
    private String pointCategory;

    @Schema(description = "추가 메시지: 계약, 계약 취소일 경우 거래 상대방 표시")
    private String counterParty;

    public ReducePointCommand(CreateCampaignCommand command) {

        this.memberId = command.getRegisterId();
        this.reducingPoint = CampaignConstant.campaignFee;
        this.pointCategory = CampaignConstant.createCampaignPointCategory;
        this.counterParty = CampaignConstant.createCampaignCounterParty;
    }
}