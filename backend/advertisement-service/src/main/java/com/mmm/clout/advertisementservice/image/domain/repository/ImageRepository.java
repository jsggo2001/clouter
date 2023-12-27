package com.mmm.clout.advertisementservice.image.domain.repository;

import com.mmm.clout.advertisementservice.image.domain.Image;

import java.util.List;

public interface ImageRepository {

    Image save(Image image);

    List<Image> findByAdvertisementId(Long advertisementId);

    List<Image> findByCampaignIdIn(List<Long> idList);

    Image delete(Long id);

    Image find(Long id);

    List<Image> findByCampaignId(Long id);

    void deleteImage(Long id);
}
