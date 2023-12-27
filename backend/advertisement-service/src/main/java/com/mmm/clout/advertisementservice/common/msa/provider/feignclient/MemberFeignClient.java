package com.mmm.clout.advertisementservice.common.msa.provider.feignclient;

import com.mmm.clout.advertisementservice.common.msa.info.AdvertiserInfo;
import com.mmm.clout.advertisementservice.common.msa.info.ClouterInfo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "member-service")
public interface MemberFeignClient {

    @GetMapping("/v1/advertisers/{advertiserId}")
    AdvertiserInfo selectAdvertiser(@PathVariable Long advertiserId);

    @GetMapping("/v1/clouters/{clouterId}")
    ClouterInfo selectClouter(
        @PathVariable("clouterId") Long clouterId
    );
}
