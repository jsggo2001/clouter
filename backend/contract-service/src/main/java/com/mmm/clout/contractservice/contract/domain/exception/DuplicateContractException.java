package com.mmm.clout.contractservice.contract.domain.exception;

import com.mmm.clout.contractservice.common.exception.CustomBaseException;
import com.mmm.clout.contractservice.common.exception.ErrorCode;

public class DuplicateContractException extends CustomBaseException {
    public DuplicateContractException() {
        super(ErrorCode.DUPLICATE_CONTRACT);
    }
}
