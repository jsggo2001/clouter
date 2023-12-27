package com.mmm.clout.pointservice.point.presentation.request;

import com.mmm.clout.pointservice.point.application.command.ReduceCommand;
import com.mmm.clout.pointservice.point.domain.PointCategory;
import io.swagger.v3.oas.annotations.media.Schema;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ReducePointRequest {

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

    public ReduceCommand toCommand() {
        return new ReduceCommand(
            memberId,
            reducingPoint,
            PointCategory.valueOf(pointCategory),
            counterParty
        );
    }
}
