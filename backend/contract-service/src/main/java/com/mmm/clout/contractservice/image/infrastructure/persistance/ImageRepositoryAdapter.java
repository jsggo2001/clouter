package com.mmm.clout.contractservice.image.infrastructure.persistance;

import com.mmm.clout.contractservice.image.domain.Image;
import com.mmm.clout.contractservice.image.domain.repository.ImageRepository;
import com.mmm.clout.contractservice.image.infrastructure.persistance.jpa.JpaImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class ImageRepositoryAdapter implements ImageRepository {
    private final JpaImageRepository jpaImageRepository;

    @Override
    public Image save(Image image) {return jpaImageRepository.save(image);}

    @Override
    public Image findByContractId(Long contractId) {
        return jpaImageRepository.findByContract_Id(contractId);
    }

    @Override
    public Image delete(Long id){
        Image image = jpaImageRepository.findById(id)
                .orElseThrow(IllegalAccessError::new);

        jpaImageRepository.deleteById(id);
        return image;
    }

    @Override
    public Image find(Long id){
        Image image = jpaImageRepository.findById(id)
                .orElseThrow(IllegalAccessError::new);

        return image;
    }
}
