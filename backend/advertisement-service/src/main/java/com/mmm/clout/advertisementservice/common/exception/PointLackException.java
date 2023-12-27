package com.mmm.clout.advertisementservice.common.exception;

public class PointLackException extends CustomBaseException {
    public PointLackException() {
        super(ErrorCode.LACK_OF_POINT);
    }
}
