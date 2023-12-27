package com.mmm.clout.advertisementservice.common.msa.provider;

import com.mmm.clout.advertisementservice.common.msa.info.AdvertiserInfo;
import com.mmm.clout.advertisementservice.common.msa.info.ClouterInfo;
import com.mmm.clout.advertisementservice.common.msa.provider.feignclient.MemberFeignClient;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class MemberFeignClientProviderAdapter implements MemberProvider {

    private final MemberFeignClient memberFeignClient;

    @Override
    public AdvertiserInfo getAdvertiserInfoByMemberId(Long memberId) {
        return memberFeignClient.selectAdvertiser(memberId);
    }

    @Override
    public ClouterInfo getClouterInfoByMemberId(Long memberId) {
        return memberFeignClient.selectClouter(memberId);
    }
}
