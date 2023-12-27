package com.mmm.clout.pointservice.point.domain.exception;

import com.mmm.clout.pointservice.common.exception.CustomBaseException;
import com.mmm.clout.pointservice.common.exception.ErrorCode;

public class EmptyTransactionException extends CustomBaseException {

    public EmptyTransactionException() {
        super(ErrorCode.EMPTY_POINT_TRANSACTION);
    }
}
