package com.mmm.clout.contractservice.contract.domain.info;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class HopeCostInfo {

    private Long minCost;

    private Long maxCost;

//    public HopeCostResponse(HopeCostReader hopeCost) {
//        this.minCost = hopeCost.getMinCost();
//        this.maxCost = hopeCost.getMaxCost();
//    }

}
