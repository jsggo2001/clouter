package com.mmm.clout.pointservice.point.infrastructure;

import static com.mmm.clout.pointservice.point.domain.QPointTransaction.pointTransaction;
import static org.springframework.util.StringUtils.hasText;

import com.mmm.clout.pointservice.point.domain.Point;
import com.mmm.clout.pointservice.point.domain.PointCategory;
import com.mmm.clout.pointservice.point.domain.PointTransaction;
import com.mmm.clout.pointservice.point.domain.exception.InvalidCategoryException;
import com.mmm.clout.pointservice.point.domain.repository.PointTransactionRepository;
import com.mmm.clout.pointservice.point.infrastructure.persistence.jpa.JpaPointTransactionRepository;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.support.PageableExecutionUtils;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class PointTransactionRepositoryAdapter implements PointTransactionRepository {

    private final JpaPointTransactionRepository jpaPointTransactionRepository;
    private final JPAQueryFactory queryFactory;


    @Override
    public PointTransaction save(PointTransaction chargedPtx) {
        return jpaPointTransactionRepository.save(chargedPtx);
    }

    @Override
    public Page<PointTransaction> searchByCategory(Point point, String category,
        PageRequest pageable) {
        List<PointTransaction> content = queryFactory.query()
            .select(pointTransaction)
            .from(pointTransaction)
            .where(
                pointEq(point).and(categoryEq(category))
            )
            .orderBy(pointTransaction.createdAt.desc())
            .offset(pageable.getOffset())
            .limit(pageable.getPageSize())
            .fetch();

        JPAQuery<PointTransaction> countQuery = getCountQuery(category, point);

        return PageableExecutionUtils.getPage(content, pageable, countQuery::fetchCount);
    }

    private JPAQuery<PointTransaction> getCountQuery(String category, Point point) {
        JPAQuery<PointTransaction> countQuery = queryFactory.query()
            .select(pointTransaction)
            .from(pointTransaction)
            .where(
                pointEq(point).and(categoryEq(category))
            );
        return countQuery;
    }

    private BooleanExpression pointEq(Point point) {
        return pointTransaction.point.eq(point);
    }

    private BooleanExpression categoryEq(String category) {
        if (!hasText(category)) {
            throw new InvalidCategoryException();
        }
        switch (category) {
            case "ALL":
                return null; // 모든 카테고리
            case "DEAL":  // 거래 카테고리 - 계약, 캠페인 등록
                return pointTransaction.pointCategory.eq(PointCategory.CONTRACT)
                    .or(pointTransaction.pointCategory.eq(PointCategory.CREATE_CAMPAIGN));
            case "CHARGE":  // 충전 카테고리
                return pointTransaction.pointCategory.eq(PointCategory.CHARGE);
            case "WITHDRAWAL":  // 출금 카테고리
                return pointTransaction.pointCategory.eq(PointCategory.WITHDRAWAL);
            default:
                throw new InvalidCategoryException();
        }
    }
}
