package com.mmm.clout.advertisementservice.common.msa.provider;

import com.mmm.clout.advertisementservice.apply.application.command.CreateContractCommand;
import com.mmm.clout.advertisementservice.common.msa.info.CreateContractInfo;
import org.springframework.http.ResponseEntity;

public interface ContractProvider {

    public ResponseEntity<CreateContractInfo> create(CreateContractCommand createAdrRequest);
}
