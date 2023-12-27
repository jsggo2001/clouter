package com.mmm.clout.memberservice.clouter.application.command;

import com.mmm.clout.memberservice.clouter.domain.HopeCost;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class HopeCostCommand {

    private Long minCost;

    public HopeCost toValueType() {
        return new HopeCost(
            this.minCost
        );
    }
}
