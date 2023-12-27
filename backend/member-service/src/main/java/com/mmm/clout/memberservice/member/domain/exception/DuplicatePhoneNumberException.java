package com.mmm.clout.memberservice.member.domain.exception;

import com.mmm.clout.memberservice.common.exception.CustomBaseException;
import com.mmm.clout.memberservice.common.exception.ErrorCode;

public class DuplicatePhoneNumberException extends CustomBaseException {
    public DuplicatePhoneNumberException() {
        super(ErrorCode.DUPLICATE_PHONE_NUMBER);
    }
}
