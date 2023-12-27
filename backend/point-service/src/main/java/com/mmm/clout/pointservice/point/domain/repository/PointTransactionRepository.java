package com.mmm.clout.pointservice.point.domain.repository;

import com.mmm.clout.pointservice.point.domain.Point;
import com.mmm.clout.pointservice.point.domain.PointCategory;
import com.mmm.clout.pointservice.point.domain.PointTransaction;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

public interface PointTransactionRepository {

    PointTransaction save(PointTransaction chargedPtx);

    Page<PointTransaction> searchByCategory(Point point, String category, PageRequest pageable);

}
