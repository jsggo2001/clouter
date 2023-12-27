package com.mmm.clout.advertisementservice.apply.application.command;

import com.mmm.clout.advertisementservice.apply.domain.Apply;
import com.mmm.clout.advertisementservice.apply.infrastructure.constant.DateConstants;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class CreateContractCommand {

    private String name;

    private Long applyId;

    private Long price;

    private String postDeadline;

    private String contractExpiration;

    private String contents;

    private Long advertiserId;

    private Long clouterId;

    private String path;

    public CreateContractCommand(Apply apply, String path) {
        this.name = apply.getCampaign().getTitle();
        hopeFeeCheck(apply);
        this.applyId = apply.getId();
        this.postDeadline = DateConstants.ONE_MONTH;
        this.contractExpiration = DateConstants.SIX_MONTH;
        this.contents = apply.getCampaign().getDetails();
        this.advertiserId = apply.getCampaign().getAdvertiserId();
        this.clouterId = apply.getApplicant().getApplicantId();
        this.path = path;
    }

    private void hopeFeeCheck(Apply apply) {
        if (apply.getHopeAdFee() <= 0 || apply.getHopeAdFee() == null) {
            this.price = apply.getCampaign().getPrice();
        } else {
            this.price = apply.getHopeAdFee();
        }
    }
}
