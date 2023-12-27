package com.mmm.clout.pointservice.point.domain.exception;

import com.mmm.clout.pointservice.common.exception.CustomBaseException;
import com.mmm.clout.pointservice.common.exception.ErrorCode;

public class LackOfPointException extends CustomBaseException {

    public LackOfPointException() {
        super(ErrorCode.LACK_OF_POINT);
    }
}
