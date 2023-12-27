package com.mmm.clout.contractservice.contract.domain.provider;


import com.mmm.clout.contractservice.contract.domain.info.AddCountContractInfo;
import com.mmm.clout.contractservice.contract.domain.info.SelectAdrInfo;
import com.mmm.clout.contractservice.contract.domain.info.SelectClrInfo;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

public interface MemberProvider {

    public ResponseEntity<SelectClrInfo> selectClouter(Long clouterId);

    public ResponseEntity<SelectAdrInfo> selectAdvertiser(Long advertiserId);

    public ResponseEntity<AddCountContractInfo> addCount(
            List<Long> idList,
            boolean addType
    );

}
