package com.mmm.clout.advertisementservice.apply.application.reader;

import com.mmm.clout.advertisementservice.advertisements.domain.AdPlatform;
import com.mmm.clout.advertisementservice.apply.domain.Apply;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class ApplyListByClouterReader {

    private Apply apply;
    private String companyName;
    private Long advertiserAvgStar;

    private Long campaignId;

    private List<AdPlatform> adPlatformList;
}
