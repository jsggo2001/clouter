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
public class CampaignReader {

    private Campaign campaign;

    private AdvertiserInfo advertiserInfo;

    private List<Image> imageList;

    private AdvertiseSign signImage;
}
