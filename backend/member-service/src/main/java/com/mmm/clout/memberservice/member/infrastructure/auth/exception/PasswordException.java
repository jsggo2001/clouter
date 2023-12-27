package com.mmm.clout.memberservice.member.infrastructure.auth.exception;

import com.mmm.clout.memberservice.common.exception.CustomBaseException;
import com.mmm.clout.memberservice.common.exception.ErrorCode;

public class PasswordException extends CustomBaseException {
    public PasswordException() {
        super(ErrorCode.WRONG_PASSWORD);
    }
}
