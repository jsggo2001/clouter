package com.mmm.clout.memberservice.clouter.infrastructure.persistence;

import com.mmm.clout.memberservice.clouter.application.command.SearchCondition;
import com.mmm.clout.memberservice.clouter.domain.Clouter;
import com.mmm.clout.memberservice.clouter.domain.exception.NotFoundClouterException;
import com.mmm.clout.memberservice.clouter.domain.repository.ClouterRepository;
import com.mmm.clout.memberservice.clouter.domain.search.ClouterSort;
import com.mmm.clout.memberservice.clouter.infrastructure.persistence.jpa.JpaClouterRepository;
import com.mmm.clout.memberservice.common.Category;
import com.mmm.clout.memberservice.common.Platform;
import com.mmm.clout.memberservice.common.Region;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

import static com.mmm.clout.memberservice.clouter.domain.QClouter.clouter;
import static org.springframework.util.StringUtils.hasText;

@Repository
@RequiredArgsConstructor
public class ClouterRepositoryAdapter implements ClouterRepository {

    private final JpaClouterRepository jpaClouterRepository;
    private final JPAQueryFactory queryFactory;

    @Override
    public Clouter save(Clouter clouter) {
        return jpaClouterRepository.save(clouter);
    }

    @Override
    public Clouter findById(Long userId) {
        return jpaClouterRepository.findById(userId).orElseThrow(
            () -> new NotFoundClouterException()
        );
    }

    @Override
    public List<Clouter> findTop10ByOrderByAvgScoreDesc() {
        return jpaClouterRepository.findTop10ByOrderByAvgScoreDesc();
    }

    @Override
    public List<Clouter> findByIdIn(List<Long> idList) {
        return jpaClouterRepository.findByIdIn(idList);
    }

    @Override
    public List<Clouter> search(SearchCondition condition, Pageable pageable) {
        return queryFactory.query()
                .select(clouter)
                .from(clouter)
                .where(
                        keywordContains(condition.getKeyword()),
                        priceBetween(condition.getMinPrice(), condition.getMaxPrice()),
                        ageGoe(condition.getMinAge()),
                        ageLoe(condition.getMaxAge()),
                        followerGoe(condition.getMinFollower()),
                        categoryEq(condition.getCategory()),
                        regionEq(condition.getRegion()),
                        platformEq(condition.getPlatform())
                )
                .orderBy(getOrderSpecifier(condition.getSortKey()))
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .fetch();
    }

    private OrderSpecifier<?> getOrderSpecifier(ClouterSort sortKey) {
        switch (sortKey) {
            case COUNTOFCONTRACT:
                return new OrderSpecifier<>(sortKey.getOrder(), clouter.countOfContract);
            case COST:
                return new OrderSpecifier<>(sortKey.getOrder(), clouter.minCost);
            case SCORE:
                return new OrderSpecifier<>(sortKey.getOrder(), clouter.avgScore);
            default:
                throw new IllegalArgumentException("Unknown sort key: " + sortKey);
        }
    }

    @Override
    public JPAQuery<Clouter> getSearchCountQuery(SearchCondition condition) {
        JPAQuery<Clouter> countQuery = queryFactory.query()
                .select(clouter)
                .from(clouter)
                .where(
                        keywordContains(condition.getKeyword()),
                        priceBetween(condition.getMinPrice(), condition.getMaxPrice()),
                        ageGoe(condition.getMinAge()),
                        ageLoe(condition.getMaxAge()),
                        followerGoe(condition.getMinFollower()),
                        categoryEq(condition.getCategory()),
                        regionEq(condition.getRegion()),
                        platformEq(condition.getPlatform())
                );
        return countQuery;
    }

    @Override
    public Optional<Clouter> findByPhoneNumber(String phoneNumber) {
        return jpaClouterRepository.findByPhoneNumber(phoneNumber);
    }

    private BooleanExpression platformEq(List<Platform> platform) {
        if (platform.get(0) == Platform.ALL) {
            return null;
        } else {
            return clouter.channelList.any().platform.in(platform);
        }
    }

    private BooleanExpression regionEq(List<Region> region) {
        if (region.get(0) == Region.ALL) {
            return null;
        } else {
            return clouter.regionList.any().in(region);
        }
    }

    private BooleanExpression categoryEq(List<Category> category) {
        if (category.get(0) == Category.ALL) {
            return null;
        } else {
            return clouter.categoryList.any().in(category);
        }
    }

    private BooleanExpression followerGoe(Integer minFollower) {
        return (minFollower != null) ? clouter.channelList.any().followerScale.goe(minFollower) : null;
    }

    private BooleanExpression ageLoe(Integer maxAge) {
        return (maxAge != null) ? clouter.age.loe(maxAge) : null;
    }

    private BooleanExpression ageGoe(Integer minAge) {
        return (minAge != null) ? clouter.age.goe(minAge) : null;
    }

    private BooleanExpression priceBetween(Integer minPrice, Integer maxPrice) {
        return (minPrice != null && maxPrice != null) ? clouter.minCost.between(minPrice, maxPrice)
                : null;
    }

    private BooleanExpression keywordContains(String keyword) {
        return hasText(keyword) ? clouter.nickName.contains(keyword)
            .or(clouter.channelList.any().name.contains(keyword)) : null;
    }
}
