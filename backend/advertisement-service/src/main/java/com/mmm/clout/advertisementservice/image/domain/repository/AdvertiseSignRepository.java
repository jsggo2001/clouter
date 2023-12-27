package com.mmm.clout.advertisementservice.image.domain.repository;

import com.mmm.clout.advertisementservice.image.domain.AdvertiseSign;
import com.mmm.clout.advertisementservice.image.domain.Image;

import java.util.List;

public interface AdvertiseSignRepository {

    AdvertiseSign save(AdvertiseSign advertiseSign);

    List<AdvertiseSign> findByAdvertisementId(Long advertisementId);

    List<AdvertiseSign> findByCampaignIdIn(List<Long> idList);

    AdvertiseSign delete(Long id);

    AdvertiseSign find(Long id);
}
