package com.mmm.clout.pointservice.point.application.command;

import com.mmm.clout.pointservice.point.domain.PointCategory;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ReduceCommand {

    private Long memberId;

    private Long reducingPoint;

    private PointCategory pointCategory;

    private String counterParty;


}
