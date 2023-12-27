package com.mmm.clout.pointservice.point.domain.exception;

import com.mmm.clout.pointservice.common.exception.CustomBaseException;
import com.mmm.clout.pointservice.common.exception.ErrorCode;

public class InvalidCategoryException extends CustomBaseException {

    public InvalidCategoryException() {
        super(ErrorCode.INVALID_INPUT_VALUE);
    }
}
