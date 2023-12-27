package com.mmm.clout.advertisementservice.advertisements.application.command;

import com.mmm.clout.advertisementservice.advertisements.domain.AdCategory;
import com.mmm.clout.advertisementservice.advertisements.domain.AdPlatform;
import com.mmm.clout.advertisementservice.advertisements.domain.Region;
import com.mmm.clout.advertisementservice.advertisements.domain.search.CampaignSort;
import java.util.List;
import java.util.stream.Collectors;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SearchCondition {

    private List<AdCategory> category;
    private List<AdPlatform> platform;
    private Integer minAge;
    private Integer maxAge;
    private Integer minFollower;
    private Integer minPrice;
    private Integer maxPrice;
    private List<Region> region;
    private String keyword;
    private CampaignSort sortKey;

    public static SearchCondition from(
        List<AdCategory> category,
        List<AdPlatform> platform,
        Integer minAge,
        Integer maxAge,
        Integer minFollower,
        Integer minPrice,
        Integer maxPrice,
        List<Region> region,
        String keyword,
        CampaignSort sortKey
    ) {
        return new SearchCondition(
            category,
            platform,
            minAge,
            maxAge,
            minFollower,
            minPrice,
            maxPrice,
            region,
            keyword,
            sortKey
        );
    }
}
