package com.mmm.clout.pointservice.point.application;

import com.mmm.clout.pointservice.point.domain.Point;
import com.mmm.clout.pointservice.point.domain.exception.PointNotFoundException;
import com.mmm.clout.pointservice.point.domain.repository.PointRepository;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
public class GetMemberPointProcessor {

    private final PointRepository pointRepository;

    @Transactional
    public Point execute(Long memberId) {
        return pointRepository.findByMemberId(memberId)
            .orElseThrow(PointNotFoundException::new);
    }
}
