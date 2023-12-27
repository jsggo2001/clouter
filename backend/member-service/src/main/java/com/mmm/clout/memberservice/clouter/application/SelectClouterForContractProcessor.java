package com.mmm.clout.memberservice.clouter.application;

import com.mmm.clout.memberservice.clouter.application.reader.ClouterReader;
import com.mmm.clout.memberservice.clouter.domain.Clouter;
import com.mmm.clout.memberservice.clouter.domain.repository.ClouterRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
public class SelectClouterForContractProcessor {

    private final ClouterRepository clouterRepository;

    @Transactional
    public ClouterReader execute(Long clouterId) {
        Clouter clouter = clouterRepository.findById(clouterId);
        clouter.addCountOfContract(1);
        ClouterReader reader = new ClouterReader(clouter);
        return reader;
    }
}
