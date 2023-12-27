package com.mmm.clout.advertisementservice.advertisements.infrastructure.persistence.provider;

import com.mmm.clout.advertisementservice.advertisements.application.command.ReducePointCommand;
import com.mmm.clout.advertisementservice.common.msa.info.ReducePointInfo;
import com.mmm.clout.advertisementservice.advertisements.infrastructure.persistence.provider.feignclient.PointFeignClient;
import com.mmm.clout.advertisementservice.common.msa.provider.PointProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class PointFeignClientProviderAdapter implements PointProvider {

    private final PointFeignClient pointFeignClient;

    @Override
    public ResponseEntity<ReducePointInfo> reduce(ReducePointCommand request) {
        return pointFeignClient.reduce(request);
    }
}
