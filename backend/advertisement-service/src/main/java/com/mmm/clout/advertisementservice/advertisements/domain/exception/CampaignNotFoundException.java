package com.mmm.clout.advertisementservice.advertisements.domain.exception;

import com.mmm.clout.advertisementservice.common.exception.CustomBaseException;
import com.mmm.clout.advertisementservice.common.exception.ErrorCode;

public class CampaignNotFoundException extends CustomBaseException {

    public CampaignNotFoundException(
        ErrorCode errorCode
    ) {
        super(errorCode);
    }

    public CampaignNotFoundException(
    ) {
        super(ErrorCode.CAMPAIGN_NOT_FOUND);
    }
}
