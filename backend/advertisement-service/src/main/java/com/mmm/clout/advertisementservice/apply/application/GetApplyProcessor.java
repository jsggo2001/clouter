package com.mmm.clout.advertisementservice.apply.application;

import com.mmm.clout.advertisementservice.apply.domain.Apply;
import com.mmm.clout.advertisementservice.apply.domain.exception.ApplyNotFoundException;
import com.mmm.clout.advertisementservice.apply.domain.repository.ApplyRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class GetApplyProcessor {

    private final ApplyRepository applyRepository;

    public Apply execute(Long applyId) {
        return applyRepository.findById(applyId).orElseThrow(ApplyNotFoundException::new);
    }
}
