package com.mmm.clout.contractservice.contract.infrastructure.persistence;

import com.mmm.clout.contractservice.contract.domain.provider.PointProvider;
import com.mmm.clout.contractservice.contract.domain.provider.dto.*;
import com.mmm.clout.contractservice.contract.infrastructure.persistence.feign.PointServiceFeignClient;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class PointServiceFeignClientAdapter implements PointProvider {

    private final PointServiceFeignClient pointServiceFeignClient;

    @Override
    public ResponseEntity<ReducePointInfo> reduce(ReducePointRequest request) {
        return pointServiceFeignClient.reduce(request);
    }

    @Override
    public ResponseEntity<AddPointInfo> add(AddClouterPointRequest request) {
        return pointServiceFeignClient.add(request);
    }

    @Override
    public ResponseEntity<AddPointInfo> add(AddAdvertiserPointRequest request) {
        return pointServiceFeignClient.add(request);
    }
}
