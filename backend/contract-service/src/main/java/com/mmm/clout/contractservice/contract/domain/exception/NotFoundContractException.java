package com.mmm.clout.contractservice.contract.domain.exception;

import com.mmm.clout.contractservice.common.exception.CustomBaseException;
import com.mmm.clout.contractservice.common.exception.ErrorCode;

public class NotFoundContractException extends CustomBaseException {
    public NotFoundContractException() {
        super(ErrorCode.NOT_FOUND_CONTRACT);
    }
}
