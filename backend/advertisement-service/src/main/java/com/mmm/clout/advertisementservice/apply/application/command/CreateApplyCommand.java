package com.mmm.clout.advertisementservice.apply.application.command;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CreateApplyCommand {

    private Long advertisementId;

    private Long clouterId;

    private String applyMessage;

    private Long hopeAdFee;

}
