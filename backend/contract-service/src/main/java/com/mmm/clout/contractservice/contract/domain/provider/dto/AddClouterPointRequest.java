package com.mmm.clout.contractservice.contract.domain.provider.dto;


import com.mmm.clout.contractservice.contract.domain.Contract;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class AddClouterPointRequest {

    private Long memberId;

    private Long addingPoint;

    //포인트 종류 (CONTRACT, CANCEL_CONTRACT)
    private String pointCategory;

    private String counterParty;

    public AddClouterPointRequest(Contract contract) {
        this.memberId = contract.getClouterInfo().getClouterId();
        this.addingPoint = contract.getPrice();
        this.pointCategory = "CONTRACT";
        this.counterParty = contract.getAdvertiserInfo().getCompanyName();
    }
}
