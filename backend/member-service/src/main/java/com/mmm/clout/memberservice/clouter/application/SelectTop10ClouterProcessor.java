package com.mmm.clout.memberservice.clouter.application;

import com.mmm.clout.memberservice.clouter.application.reader.ClouterReader;
import com.mmm.clout.memberservice.clouter.domain.Clouter;
import com.mmm.clout.memberservice.clouter.domain.repository.ClouterRepository;
import com.mmm.clout.memberservice.image.domain.repository.ImageRepository;
import com.mmm.clout.memberservice.image.presentation.ImageResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
public class SelectTop10ClouterProcessor {

    private final ClouterRepository clouterRepository;
    private final ImageRepository imageRepository;

    @Transactional
    public List<ClouterReader> execute() {
        List<Clouter> clouters = clouterRepository.findTop10ByOrderByAvgScoreDesc();
        return clouters.stream().map(v -> new ClouterReader(v, imageRepository.findByMemberId(v.getId()).stream().map(
                        va -> new ImageResponse(va)
                ).collect(Collectors.toList()))
        ).collect(Collectors.toList());
    }

}
