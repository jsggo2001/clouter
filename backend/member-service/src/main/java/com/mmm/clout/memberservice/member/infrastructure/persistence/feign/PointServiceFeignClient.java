package com.mmm.clout.memberservice.member.infrastructure.persistence.feign;

import com.mmm.clout.memberservice.member.domain.info.CreatePointInfo;
import com.mmm.clout.memberservice.member.domain.info.CreatePointRequest;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import javax.validation.Valid;

@FeignClient("point-service")
public interface PointServiceFeignClient {

    @PostMapping("v1/points")
    public ResponseEntity<CreatePointInfo> create(
        @Valid @RequestBody CreatePointRequest request
    );
}
