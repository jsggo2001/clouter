package com.mmm.clout.advertisementservice.advertisements.domain.exception;

import com.mmm.clout.advertisementservice.common.exception.CustomBaseException;
import com.mmm.clout.advertisementservice.common.exception.ErrorCode;

public class AlreadyEndedException extends CustomBaseException {

    public AlreadyEndedException(String message,
        ErrorCode errorCode) {
        super(message, errorCode);
    }

    public AlreadyEndedException() {
        super(ErrorCode.END_RECUITS);
    }
}
