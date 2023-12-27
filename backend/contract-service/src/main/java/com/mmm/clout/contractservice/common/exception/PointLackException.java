package com.mmm.clout.contractservice.common.exception;

public class PointLackException extends CustomBaseException {
    public PointLackException() {
        super(ErrorCode.LACK_OF_POINT);
    }
}
