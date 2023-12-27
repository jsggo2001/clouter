package com.mmm.clout.pointservice.point.application;

import com.mmm.clout.pointservice.point.application.command.ReduceCommand;
import com.mmm.clout.pointservice.point.domain.Point;
import com.mmm.clout.pointservice.point.domain.PointTransaction;
import com.mmm.clout.pointservice.point.domain.exception.PointNotFoundException;
import com.mmm.clout.pointservice.point.domain.repository.PointRepository;
import com.mmm.clout.pointservice.point.domain.repository.PointTransactionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
public class ReducePointProcessor {

    private final PointRepository pointRepository;
    private final PointTransactionRepository pointTransactionRepository;


    @Transactional
    public PointTransaction execute(ReduceCommand command) {
        Point point = pointRepository.findByMemberId(command.getMemberId())
            .orElseThrow(PointNotFoundException::new);
        point.reduce(command.getReducingPoint());
        PointTransaction usedPointTsx = PointTransaction.reduce(point, command.getReducingPoint(), command.getPointCategory(), command.getCounterParty());
        return pointTransactionRepository.save(usedPointTsx);
    }
}
