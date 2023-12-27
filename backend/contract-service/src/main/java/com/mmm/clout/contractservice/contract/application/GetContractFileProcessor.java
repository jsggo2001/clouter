package com.mmm.clout.contractservice.contract.application;

import com.mmm.clout.contractservice.image.domain.Image;
import com.mmm.clout.contractservice.image.domain.repository.ImageRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
public class GetContractFileProcessor {

    private final ImageRepository imageRepository;

    public String execute(Long id) {
        Image image = imageRepository.findByContractId(id);
        log.info("execute"+image.getPath()+" "+image.getId());
        return image.getPath();
    }
}
