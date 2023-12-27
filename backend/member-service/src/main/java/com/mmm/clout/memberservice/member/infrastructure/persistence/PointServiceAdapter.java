package com.mmm.clout.memberservice.member.infrastructure.persistence;

import com.mmm.clout.memberservice.member.domain.info.CreatePointInfo;
import com.mmm.clout.memberservice.member.domain.provider.PointProvider;
import com.mmm.clout.memberservice.member.domain.info.CreatePointRequest;
import com.mmm.clout.memberservice.member.infrastructure.persistence.feign.PointServiceFeignClient;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class PointServiceAdapter implements PointProvider {

    private final PointServiceFeignClient pointServiceFeignClient;

    @Override
    public ResponseEntity<CreatePointInfo> create(CreatePointRequest request) {
        return pointServiceFeignClient.create(request);
    }
}
