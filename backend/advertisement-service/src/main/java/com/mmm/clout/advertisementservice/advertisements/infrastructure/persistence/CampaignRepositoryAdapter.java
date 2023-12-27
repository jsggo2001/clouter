package com.mmm.clout.advertisementservice.advertisements.infrastructure.persistence;

import static com.mmm.clout.advertisementservice.advertisements.domain.QCampaign.campaign;
import static org.springframework.util.StringUtils.hasText;

import com.mmm.clout.advertisementservice.advertisements.application.command.SearchCondition;
import com.mmm.clout.advertisementservice.advertisements.domain.AdCategory;
import com.mmm.clout.advertisementservice.advertisements.domain.AdPlatform;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.advertisements.domain.Region;
import com.mmm.clout.advertisementservice.advertisements.domain.repository.CampaignRepository;
import com.mmm.clout.advertisementservice.advertisements.domain.search.CampaignSort;
import com.mmm.clout.advertisementservice.advertisements.infrastructure.persistence.jpa.JpaCampaignRepository;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class CampaignRepositoryAdapter implements CampaignRepository {

    private final JpaCampaignRepository jpaCampaignRepository;
    private final JPAQueryFactory queryFactory;

    @Override
    public Campaign save(Campaign campaign) {
        return jpaCampaignRepository.save(campaign);
    }

    @Override
    public Optional<Campaign> findById(Long advertisementId) {
        return jpaCampaignRepository.findById(advertisementId);
    }

    @Override
    public List<Campaign> getTop10List() {
        Pageable pageable = PageRequest.of(0, 10);
        return queryFactory.query()
            .select(campaign)
            .from(campaign)
            .where(
                nowBetweenApplyDate(LocalDate.now()),
                endedEq(false)
            )
            .offset(pageable.getOffset())
            .limit(pageable.getPageSize())
            .fetch();
    }

    private BooleanExpression nowBetweenApplyDate(LocalDate now) {
        return campaign.applyStartDate.loe(now)
            .and(campaign.applyEndDate.goe(now));
    }


    private static BooleanExpression endedEq(boolean creteria) {
        return campaign.isEnded.eq(creteria);
    }

    @Override
    public Page<Campaign> getCampainListByAdvertiserId(Long advertiserId, Pageable pageable) {
        return jpaCampaignRepository.findByRegisterIdOrderByCreatedAtDesc(advertiserId, pageable);
    }

    @Override
    public List<Campaign> findByIdIn(List<Long> adIdList) {
        return jpaCampaignRepository.findByIdIn(adIdList);
    }

    @Override
    public List<Campaign> search(SearchCondition condition, Pageable pageable) {

        return queryFactory.query()
            .select(campaign)
            .from(campaign)
            .where(
                keywordContains(condition.getKeyword()),
                priceBetween(condition.getMinPrice(), condition.getMaxPrice()),
                ageGoe(condition.getMinAge()),
                ageLoe(condition.getMaxAge()),
                followerGoe(condition.getMinFollower()),
                categoryEq(condition.getCategory()),
                regionEq(condition.getRegion()),
                platformEq(condition.getPlatform()),
                endedEq(false)
            )
            .orderBy(getOrderSpecifier(condition.getSortKey()))
            .offset(pageable.getOffset())
            .limit(pageable.getPageSize())
            .fetch();
    }

    private OrderSpecifier<?> getOrderSpecifier(CampaignSort sortKey) {
        switch (sortKey) {
            case POPULARITY:
                return new OrderSpecifier<>(sortKey.getOrder(), campaign.numberOfApplicants);
            case NEWEST:
                return new OrderSpecifier<>(sortKey.getOrder(), campaign.createdAt);
            case DEADLINE:
                return new OrderSpecifier<>(sortKey.getOrder(), campaign.applyEndDate);
            default:
                throw new IllegalArgumentException("Unknown sort key: " + sortKey);
        }
    }

    @Override
    public JPAQuery<Campaign> getSearchCountQuery(SearchCondition condition) {
        JPAQuery<Campaign> countQuery = queryFactory.query()
            .select(campaign)
            .from(campaign)
            .where(
                keywordContains(condition.getKeyword()),
                priceBetween(condition.getMinPrice(), condition.getMaxPrice()),
                ageGoe(condition.getMinAge()),
                ageLoe(condition.getMaxAge()),
                followerGoe(condition.getMinFollower()),
                categoryEq(condition.getCategory()),
                regionEq(condition.getRegion()),
                platformEq(condition.getPlatform()),
                endedEq(false)
            );
        return countQuery;
    }

    private BooleanExpression platformEq(List<AdPlatform> platform) {
        if (platform.get(0) == AdPlatform.ALL) {
            return null;
        } else {
            return campaign.adPlatformList.any().in(platform);
        }
    }

    private BooleanExpression regionEq(List<Region> region) {
        if (region.get(0) == Region.ALL) {
            return null;
        } else {
            return campaign.regionList.any().in(region);
        }
    }

    private BooleanExpression categoryEq(List<AdCategory> category) {
        if (category.get(0) == AdCategory.ALL) {
            return null;
        } else {
            return campaign.adCategory.in(category);
        }
    }

    private BooleanExpression followerGoe(Integer minFollower) {
        return (minFollower != null) ? campaign.minFollower.goe(minFollower) : null;
    }

    private BooleanExpression ageLoe(Integer maxAge) {
        return (maxAge != null) ? campaign.maxClouterAge.loe(maxAge) : null;
    }

    private BooleanExpression ageGoe(Integer minAge) {
        return (minAge != null) ? campaign.minClouterAge.goe(minAge) : null;
    }

    private BooleanExpression priceBetween(Integer minPrice, Integer maxPrice) {
        return (minPrice != null && maxPrice != null) ? campaign.price.between(minPrice, maxPrice)
            : null;
    }

    private BooleanExpression keywordContains(String keyword) {
        return hasText(keyword) ? campaign.title.contains(keyword) : null;
    }
}
