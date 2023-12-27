package com.mmm.clout.advertisementservice.image.infrastructure.persistance;

import com.mmm.clout.advertisementservice.image.domain.Image;
import com.mmm.clout.advertisementservice.image.domain.repository.ImageRepository;
import com.mmm.clout.advertisementservice.image.infrastructure.persistance.jpa.JpaImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class ImageRepositoryAdapter implements ImageRepository {

    private final JpaImageRepository jpaImageRepository;

    @Override
    public Image save(Image image) {return jpaImageRepository.save(image);}

    @Override
    public List<Image> findByAdvertisementId(Long advertisementId) {
        return jpaImageRepository.findByCampaign_Id(advertisementId);
    }

    @Override
    public List<Image> findByCampaignIdIn(List<Long> idList) {
        return jpaImageRepository.findByCampaign_IdIn(idList);
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

    @Override
    public List<Image> findByCampaignId(Long id) {
        return jpaImageRepository.findByCampaign_Id(id);
    }

    @Override
    public void deleteImage(Long id) {
        jpaImageRepository.deleteById(id);
    }
}
