package com.mmm.clout.contractservice.contract.domain.provider;


import com.mmm.clout.contractservice.contract.domain.provider.dto.*;
import org.springframework.http.ResponseEntity;

public interface PointProvider {
    public ResponseEntity<ReducePointInfo> reduce(ReducePointRequest request);

    public ResponseEntity<AddPointInfo> add(AddClouterPointRequest request);

    public ResponseEntity<AddPointInfo> add(AddAdvertiserPointRequest request);
}
