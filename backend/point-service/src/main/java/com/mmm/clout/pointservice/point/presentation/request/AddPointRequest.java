package com.mmm.clout.pointservice.point.presentation.request;

import com.mmm.clout.pointservice.point.application.command.AddPointCommand;
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
public class AddPointRequest {

    @Schema(description = "멤버 고유 식별자 (id)")
    @NotNull
    private Long memberId;

    @Schema(description = "지급할 포인트")
    @NotNull
    private Long addingPoint;

    @Schema(description = "포인트 종류 (CONTRACT, CANCEL_CONTRACT)")
    @NotBlank
    private String pointCategory;

    @Schema(description = "추가 메시지: 계약, 계약 취소일 경우 거래 상대방 표시")
    private String counterParty;
    public AddPointCommand toCommand() {
        return new AddPointCommand(
            memberId,
            addingPoint,
            PointCategory.valueOf(pointCategory),
            counterParty
        );
    }
}
