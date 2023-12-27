package com.mmm.clout.contractservice.contract.domain.provider.dto;


import com.mmm.clout.contractservice.contract.domain.AdvertiserInfo;
import com.mmm.clout.contractservice.contract.domain.ClouterInfo;
import com.mmm.clout.contractservice.contract.domain.info.SelectAdrInfo;
import com.mmm.clout.contractservice.contract.domain.info.SelectClrInfo;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ReducePointRequest {

    private Long memberId;

    private Long reducingPoint;

    //포인트 종류 (CONTRACT, CANCEL_CONTRACT, CREATE_CAMPAIGN)
    private String pointCategory;

    //추가 메시지: 계약, 계약 취소일 경우 거래 상대방 표시
    private String counterParty;

    public ReducePointRequest(SelectAdrInfo adInfo, SelectClrInfo clouterInfo, Long reducingPoint) {
        this.memberId = adInfo.getAdvertiserId();
        this.reducingPoint = reducingPoint;
        this.pointCategory = "CONTRACT";
        this.counterParty = clouterInfo.getName();
    }
}
