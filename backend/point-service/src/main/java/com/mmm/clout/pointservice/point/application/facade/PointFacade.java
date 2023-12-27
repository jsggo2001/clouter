package com.mmm.clout.pointservice.point.application.facade;

import com.mmm.clout.pointservice.point.application.AddPointProcessor;
import com.mmm.clout.pointservice.point.application.ChargePointProcessor;
import com.mmm.clout.pointservice.point.application.CreatePointProcessor;
import com.mmm.clout.pointservice.point.application.GetMemberPointProcessor;
import com.mmm.clout.pointservice.point.application.GetTransactionListByCategoryProcessor;
import com.mmm.clout.pointservice.point.application.ReducePointProcessor;
import com.mmm.clout.pointservice.point.application.WithdrawPointProcessor;
import com.mmm.clout.pointservice.point.application.command.AddPointCommand;
import com.mmm.clout.pointservice.point.application.command.ChargeCommand;
import com.mmm.clout.pointservice.point.application.command.ReduceCommand;
import com.mmm.clout.pointservice.point.application.command.WithdrawCommand;
import com.mmm.clout.pointservice.point.domain.Point;
import com.mmm.clout.pointservice.point.domain.PointTransaction;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class PointFacade {

    private final ChargePointProcessor chargePointProcessor;
    private final ReducePointProcessor reducePointProcessor;
    private final WithdrawPointProcessor withdrawPointProcessor;
    private final GetMemberPointProcessor getMemberPointProcessor;
    private final GetTransactionListByCategoryProcessor getTransactionListByCategoryProcessor;
    private final AddPointProcessor addPointProcessor;
    private final CreatePointProcessor createPointProcessor;

    public PointTransaction charge(ChargeCommand command) {
        return chargePointProcessor.execute(command);
    }

    public PointTransaction reduce(ReduceCommand command) {
        return reducePointProcessor.execute(command);
    }

    public void withdrawal(WithdrawCommand command) {
        withdrawPointProcessor.execute(command);
    }

    public Point getMemberPoint(Long memberId) {
        return getMemberPointProcessor.execute(memberId);
    }

    public Page<PointTransaction> getTransactionListByCategory(
        Long memberId,
        String category,
        PageRequest pageable
    ) {
        return getTransactionListByCategoryProcessor.execute(memberId, category, pageable);
    }

    public PointTransaction add(AddPointCommand command) {
        return addPointProcessor.execute(command);
    }

    public Point create(Long memberId) {
        return createPointProcessor.execute(memberId);
    }
}
