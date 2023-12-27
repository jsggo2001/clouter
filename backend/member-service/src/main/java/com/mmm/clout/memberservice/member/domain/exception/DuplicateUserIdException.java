package com.mmm.clout.memberservice.member.domain.exception;

import com.mmm.clout.memberservice.common.exception.CustomBaseException;
import com.mmm.clout.memberservice.common.exception.ErrorCode;

public class DuplicateUserIdException extends CustomBaseException {
    public DuplicateUserIdException() {
        super(ErrorCode.DUPLICATE_USER_ID);
    }
}
