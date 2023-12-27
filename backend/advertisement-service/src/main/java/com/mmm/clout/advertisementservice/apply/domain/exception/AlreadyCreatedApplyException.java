package com.mmm.clout.advertisementservice.apply.domain.exception;

import com.mmm.clout.advertisementservice.common.exception.CustomBaseException;
import com.mmm.clout.advertisementservice.common.exception.ErrorCode;

public class AlreadyCreatedApplyException extends CustomBaseException {

    public AlreadyCreatedApplyException() {
        super(ErrorCode.ALREADY_CREATED_APPLY);
    }
}
