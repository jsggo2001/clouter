package com.mmm.clout.contractservice.image.domain.repository;

import com.mmm.clout.contractservice.image.domain.Image;

public interface ImageRepository {

    Image save(Image image);

    Image findByContractId(Long contractId);

    Image delete(Long id);

    Image find(Long id);
}
