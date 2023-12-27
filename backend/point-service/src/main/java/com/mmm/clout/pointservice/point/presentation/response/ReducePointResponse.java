package com.mmm.clout.pointservice.point.presentation.response;

import com.mmm.clout.pointservice.point.domain.Point;
import com.mmm.clout.pointservice.point.domain.PointTransaction;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ReducePointResponse {

    @Schema(description = "포인트 고유 식별자(id)")
    private Long pointId;

    @Schema(description = "멤버 고유 식별자(id)")
    private Long memberId;

    @Schema(description = "사용/차감한 포인트")
    private Long reducedPoint;

    @Schema(description = "현재 멤버 총 포인트")
    private Long totalPoint;


    public static ReducePointResponse from(PointTransaction pts) {
        return new ReducePointResponse(
            pts.getPoint().getId(),
            pts.getPoint().getMemberId(),
            pts.getAmount(),
            pts.getPoint().getTotalPoint()
        );
    }
}
