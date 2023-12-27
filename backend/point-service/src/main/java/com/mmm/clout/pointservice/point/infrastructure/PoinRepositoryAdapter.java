package com.mmm.clout.pointservice.point.infrastructure;

import com.mmm.clout.pointservice.point.domain.Point;
import com.mmm.clout.pointservice.point.domain.repository.PointRepository;
import com.mmm.clout.pointservice.point.infrastructure.persistence.jpa.JpaPointRepository;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class PoinRepositoryAdapter implements PointRepository {


    private final JpaPointRepository jpaPointRepository;

    @Override
    public Point save(Point chargedPoint) {
        return jpaPointRepository.save(chargedPoint);
    }

    @Override
    public Optional<Point> findByMemberId(Long memberId) {
        return jpaPointRepository.findByMemberId(memberId);
    }
}
