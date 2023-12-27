package com.mmm.clout.contractservice.contract.infrastructure.persistence.feign;

import com.mmm.clout.contractservice.contract.domain.provider.dto.*;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import javax.validation.Valid;

@FeignClient("point-service")
public interface PointServiceFeignClient {

    @PostMapping("/v1/points/reduce")
    public ResponseEntity<ReducePointInfo> reduce(
            @Valid @RequestBody ReducePointRequest request
    );

    @PostMapping("/v1/points/add")
    public ResponseEntity<AddPointInfo> add(
            @Valid @RequestBody AddClouterPointRequest request
    );

    @PostMapping("/v1/points/add")
    public ResponseEntity<AddPointInfo> add(
            @Valid @RequestBody AddAdvertiserPointRequest request
    );
}
