package com.mmm.clout.pointservice.point.presentation.response;

import com.mmm.clout.pointservice.point.domain.Point;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CreatePointResponse {

    private Long createdPointId;

    private Long memberId;


    public static CreatePointResponse from(Point point) {
        return new CreatePointResponse(point.getId(), point.getMemberId());
    }
}
