package com.mmm.clout.advertisementservice.common.msa.provider;


import com.mmm.clout.advertisementservice.common.msa.info.AdvertiserInfo;
import com.mmm.clout.advertisementservice.common.msa.info.ClouterInfo;

public interface MemberProvider {

    AdvertiserInfo getAdvertiserInfoByMemberId(Long memberId);

    ClouterInfo getClouterInfoByMemberId(Long memberId);

}
