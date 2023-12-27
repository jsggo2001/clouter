package com.mmm.clout.memberservice.clouter.domain.exception;

import com.mmm.clout.memberservice.common.exception.CustomBaseException;
import com.mmm.clout.memberservice.common.exception.ErrorCode;

public class CreatePlatformAllDenyException extends CustomBaseException {
    public CreatePlatformAllDenyException() {
        super(ErrorCode.CREATE_PLATFORM_ALL_DENY);
    }
}
