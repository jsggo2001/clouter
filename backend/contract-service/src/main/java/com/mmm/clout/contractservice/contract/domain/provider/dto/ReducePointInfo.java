package com.mmm.clout.contractservice.contract.domain.provider.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ReducePointInfo {

    private Long pointId;

    private Long memberId;

    private Long reducedPoint;

    private Long totalPoint;
}
