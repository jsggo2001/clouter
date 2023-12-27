package com.mmm.clout.advertisementservice.apply.domain.exception;

import com.mmm.clout.advertisementservice.common.exception.CustomBaseException;
import com.mmm.clout.advertisementservice.common.exception.ErrorCode;

public class CannotCancelApplyException extends CustomBaseException {

    public CannotCancelApplyException(
        String message,
        ErrorCode errorCode
    ) {
        super(message, errorCode);
    }

    public CannotCancelApplyException() {
        super(ErrorCode.ALREADY_ACCEPTED_APPLY);
    }
}
