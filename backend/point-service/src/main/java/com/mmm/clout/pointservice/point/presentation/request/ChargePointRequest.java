package com.mmm.clout.pointservice.point.presentation.request;

import com.mmm.clout.pointservice.point.application.command.ChargeCommand;
import com.mmm.clout.pointservice.point.domain.PaymentType;
import io.swagger.v3.oas.annotations.media.Schema;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ChargePointRequest {

    @Schema(description = "사용자 고유 식별자(id)")
    @NotNull
    private Long memberId;

    @Schema(description = "충전할 포인트(1000원 이상만 가능)")
    @NotNull
    @Min(1000)
    private Long chargePoint;

    @Schema(description = "충전 수단 (현재 KAKAO)")
    @NotNull
    private PaymentType paymentType;

    public ChargeCommand toCommand() {
        return new ChargeCommand(memberId, chargePoint, paymentType);
    }
}
