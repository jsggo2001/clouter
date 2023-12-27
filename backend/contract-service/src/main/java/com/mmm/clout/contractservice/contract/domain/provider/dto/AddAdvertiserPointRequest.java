package com.mmm.clout.contractservice.contract.domain.provider.dto;


import com.mmm.clout.contractservice.contract.domain.Contract;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class AddAdvertiserPointRequest {

    private Long memberId;

    private Long addingPoint;

    //포인트 종류 (CONTRACT, CANCEL_CONTRACT)
    private String pointCategory;

    private String counterParty;

    public AddAdvertiserPointRequest(Contract contract) {
        this.memberId = contract.getAdvertiserInfo().getAdvertiserId();
        this.addingPoint = contract.getPrice();
        this.pointCategory = "CONTRACT";
        this.counterParty = contract.getClouterInfo().getClouterName();
    }
}
