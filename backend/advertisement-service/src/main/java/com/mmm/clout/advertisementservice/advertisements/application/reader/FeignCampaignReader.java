package com.mmm.clout.advertisementservice.advertisements.application.reader;

import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.common.msa.info.AdvertiserInfo;
import com.mmm.clout.advertisementservice.image.domain.AdvertiseSign;
import com.mmm.clout.advertisementservice.image.domain.Image;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class FeignCampaignReader {

    private Campaign campaign;

    private List<Image> imageList;
}
