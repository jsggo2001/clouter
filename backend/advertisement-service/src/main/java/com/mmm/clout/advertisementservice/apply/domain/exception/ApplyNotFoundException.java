package com.mmm.clout.advertisementservice.apply.domain.exception;

import com.mmm.clout.advertisementservice.common.exception.CustomBaseException;
import com.mmm.clout.advertisementservice.common.exception.ErrorCode;

public class ApplyNotFoundException extends CustomBaseException {

    public ApplyNotFoundException(String message,
        ErrorCode errorCode) {
        super(message, errorCode);
    }

    public ApplyNotFoundException() {
        super(ErrorCode.APPLY_NOT_FOUND);
    }
}
