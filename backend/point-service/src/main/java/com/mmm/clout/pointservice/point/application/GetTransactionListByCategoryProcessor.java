package com.mmm.clout.pointservice.point.application;

import static com.mmm.clout.pointservice.point.domain.QPointTransaction.pointTransaction;
import static org.springframework.util.StringUtils.hasText;

import com.mmm.clout.pointservice.point.domain.PointCategory;
import com.mmm.clout.pointservice.point.domain.exception.InvalidCategoryException;
import com.mmm.clout.pointservice.point.domain.Point;
import com.mmm.clout.pointservice.point.domain.PointTransaction;
import com.mmm.clout.pointservice.point.domain.exception.PointNotFoundException;
import com.mmm.clout.pointservice.point.domain.repository.PointRepository;
import com.mmm.clout.pointservice.point.domain.repository.PointTransactionRepository;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;
import java.util.List;
import javax.transaction.Transaction;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.support.PageableExecutionUtils;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
public class GetTransactionListByCategoryProcessor {

    private final PointRepository pointRepository;
    private final PointTransactionRepository pointTransactionRepository;

    @Transactional
    public Page<PointTransaction> execute(Long memberId, String category, PageRequest pageable) {

        Point point = pointRepository.findByMemberId(memberId)
            .orElseThrow(PointNotFoundException::new);

        return pointTransactionRepository.searchByCategory(point, category, pageable);
    }


}
