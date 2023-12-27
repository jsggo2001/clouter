package com.mmm.clout.memberservice.clouter.application.reader;

import com.mmm.clout.memberservice.clouter.domain.HopeCost;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class HopeCostReader {

    @Schema(description = "원하는 최소 금액")
    private Long minCost;

    @Schema(description = "원하는 최대 금액")
    private Long maxCost;

    public HopeCostReader(HopeCost hopeCost) {
        this.minCost = hopeCost.getMinCost();
    }

}
