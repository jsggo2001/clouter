package com.mmm.clout.pointservice.point.infrastructure.persistence.jpa;

import com.mmm.clout.pointservice.point.domain.Point;
import com.mmm.clout.pointservice.point.domain.PointCategory;
import com.mmm.clout.pointservice.point.domain.PointTransaction;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface JpaPointTransactionRepository extends JpaRepository<PointTransaction, Long> {

    List<PointTransaction> findByPointAndPointCategory(Point point, PointCategory category);

}
