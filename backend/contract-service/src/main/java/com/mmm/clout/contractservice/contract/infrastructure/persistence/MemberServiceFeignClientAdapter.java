package com.mmm.clout.contractservice.contract.infrastructure.persistence;

import com.mmm.clout.contractservice.contract.domain.info.AddCountContractInfo;
import com.mmm.clout.contractservice.contract.domain.info.SelectAdrInfo;
import com.mmm.clout.contractservice.contract.domain.info.SelectClrInfo;
import com.mmm.clout.contractservice.contract.domain.provider.MemberProvider;
import com.mmm.clout.contractservice.contract.infrastructure.persistence.feign.MemberServiceFeignClient;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@RequiredArgsConstructor
public class MemberServiceFeignClientAdapter implements MemberProvider {

    private final MemberServiceFeignClient memberServiceFeignClient;

    @Override
    public ResponseEntity<SelectClrInfo> selectClouter(Long clouterId) {
        return memberServiceFeignClient.selectClouter(clouterId);
    }

    @Override
    public ResponseEntity<SelectAdrInfo> selectAdvertiser(Long advertiserId) {
        return memberServiceFeignClient.selectAdvertiser(advertiserId);
    }

    @Override
    public ResponseEntity<AddCountContractInfo> addCount(List<Long> idList, boolean addType) {
        return memberServiceFeignClient.addCount(idList, addType);
    }
}
