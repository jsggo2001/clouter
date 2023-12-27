package com.mmm.clout.advertisementservice.common.msa.provider;

import com.mmm.clout.advertisementservice.advertisements.application.command.ReducePointCommand;
import com.mmm.clout.advertisementservice.common.msa.info.ReducePointInfo;
import org.springframework.http.ResponseEntity;

public interface PointProvider {

    ResponseEntity<ReducePointInfo> reduce(ReducePointCommand request);

}
