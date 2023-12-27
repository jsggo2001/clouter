package com.mmm.clout.pointservice.point.application.command;

import com.mmm.clout.pointservice.point.domain.PaymentType;
import com.mmm.clout.pointservice.point.domain.Point;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ChargeCommand {

    private Long memberId;

    private Long chargePoint;

    private PaymentType paymentType;



}
