package com.mmm.clout.pointservice.point.presentation.response;

import com.mmm.clout.pointservice.point.domain.Point;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class GetMemberTotalPointResponse {

    @Schema(description = "포인트 고유 식별자(id)")
    private Long pointId;

    @Schema(description = "회원 고유 식별자(id)")
    private Long memberId;

    @Schema(description = "해당 회원의 현재 총 포인트")
    private Long totalPoint;


    public static GetMemberTotalPointResponse from(Point point) {
        return new GetMemberTotalPointResponse(
            point.getId(),
            point.getMemberId(),
            point.getTotalPoint()
        );
    }
}
