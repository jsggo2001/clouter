package com.mmm.clout.advertisementservice.apply.domain.exception;

import com.mmm.clout.advertisementservice.common.exception.CustomBaseException;
import com.mmm.clout.advertisementservice.common.exception.ErrorCode;

public class CancelApplyException extends CustomBaseException {

    public CancelApplyException(String message,
        ErrorCode errorCode) {
        super(message, errorCode);
    }

    public CancelApplyException() {
        super(ErrorCode.APPLY_IS_CANCELED);
    }
}
