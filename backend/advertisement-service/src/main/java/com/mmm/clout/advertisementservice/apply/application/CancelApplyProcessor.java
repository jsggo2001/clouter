package com.mmm.clout.advertisementservice.apply.application;

import com.mmm.clout.advertisementservice.apply.domain.Apply;
import com.mmm.clout.advertisementservice.apply.domain.repository.ApplyRepository;
import javax.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
public class CancelApplyProcessor {

    private final ApplyRepository applyRepository;


    @Transactional
    public void execute(Long applyId) {
        Apply apply = applyRepository.findById(applyId).orElseThrow(EntityNotFoundException::new);
        apply.cancelApply();
    }
}
