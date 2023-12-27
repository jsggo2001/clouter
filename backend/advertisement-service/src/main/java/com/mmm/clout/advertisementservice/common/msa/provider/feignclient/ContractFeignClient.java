package com.mmm.clout.advertisementservice.common.msa.provider.feignclient;

import com.mmm.clout.advertisementservice.apply.application.command.CreateContractCommand;
import com.mmm.clout.advertisementservice.common.msa.info.CreateContractInfo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import javax.validation.Valid;

@FeignClient(name = "contract-service")
public interface ContractFeignClient {

    @PostMapping("/v1/contracts")
    public ResponseEntity<CreateContractInfo> create(
        @RequestBody @Valid CreateContractCommand createAdrRequest
    );
}
