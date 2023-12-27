package com.mmm.clout.advertisementservice.common.msa.provider;

import com.mmm.clout.advertisementservice.apply.application.command.CreateContractCommand;
import com.mmm.clout.advertisementservice.common.msa.info.CreateContractInfo;
import com.mmm.clout.advertisementservice.common.msa.provider.feignclient.ContractFeignClient;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class ContractFeignClientProviderAdapter implements ContractProvider {

    private final ContractFeignClient contractFeignClient;

    @Override
    public ResponseEntity<CreateContractInfo> create(CreateContractCommand command) {
        return contractFeignClient.create(command);
    }
}
