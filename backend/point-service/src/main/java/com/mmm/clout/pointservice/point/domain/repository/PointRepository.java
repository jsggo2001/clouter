package com.mmm.clout.pointservice.point.domain.repository;

import com.mmm.clout.pointservice.point.domain.Point;
import java.util.Optional;

public interface PointRepository {

    Point save(Point chargedPoint);

    Optional<Point> findByMemberId(Long memberId);
}
