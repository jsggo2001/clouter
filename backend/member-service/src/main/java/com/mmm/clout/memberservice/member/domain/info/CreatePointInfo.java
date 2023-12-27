package com.mmm.clout.memberservice.member.domain.info;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CreatePointInfo {

    private Long createdPointId;

    private Long memberId;
}
