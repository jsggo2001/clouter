package com.mmm.clout.memberservice.clouter.application.command;

import com.mmm.clout.memberservice.clouter.domain.search.ClouterSort;
import com.mmm.clout.memberservice.common.Category;
import com.mmm.clout.memberservice.common.Platform;
import com.mmm.clout.memberservice.common.Region;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class SearchCondition {

    private List<Category> category;
    private List<Platform> platform;
    private Integer minAge;
    private Integer maxAge;
    private Integer minFollower;
    private Integer minPrice;
    private Integer maxPrice;
    private List<Region> region;
    private String keyword;
    private ClouterSort sortKey;

    public static SearchCondition from(
        List<Category> category,
        List<Platform> platform,
        Integer minAge,
        Integer maxAge,
        Integer minFollower,
        Integer minPrice,
        Integer maxPrice,
        List<Region> region,
        String keyword,
        ClouterSort sortKey
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
