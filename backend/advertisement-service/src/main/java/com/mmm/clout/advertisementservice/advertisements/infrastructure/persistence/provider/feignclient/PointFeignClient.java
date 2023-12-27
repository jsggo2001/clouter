package com.mmm.clout.advertisementservice.advertisements.infrastructure.persistence.provider.feignclient;

import com.mmm.clout.advertisementservice.advertisements.application.command.ReducePointCommand;
import com.mmm.clout.advertisementservice.common.msa.info.ReducePointInfo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import javax.validation.Valid;

@FeignClient(name = "point-service")
public interface PointFeignClient {

    @PostMapping("/v1/points/reduce")
    public ResponseEntity<ReducePointInfo> reduce(
            @Valid @RequestBody ReducePointCommand request);
}
