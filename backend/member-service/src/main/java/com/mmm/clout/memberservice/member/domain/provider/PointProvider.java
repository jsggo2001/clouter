package com.mmm.clout.memberservice.member.domain.provider;

import com.mmm.clout.memberservice.member.domain.info.CreatePointInfo;
import com.mmm.clout.memberservice.member.domain.info.CreatePointRequest;
import org.springframework.http.ResponseEntity;

public interface PointProvider {
    public ResponseEntity<CreatePointInfo> create(CreatePointRequest request);
}
