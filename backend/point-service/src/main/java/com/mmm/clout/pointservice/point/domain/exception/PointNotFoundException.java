package com.mmm.clout.pointservice.point.domain.exception;

import com.mmm.clout.pointservice.common.exception.CustomBaseException;
import com.mmm.clout.pointservice.common.exception.ErrorCode;

public class PointNotFoundException extends CustomBaseException {

    public PointNotFoundException() {
        super(ErrorCode.POINT_NOT_FOUND);
    }
}
