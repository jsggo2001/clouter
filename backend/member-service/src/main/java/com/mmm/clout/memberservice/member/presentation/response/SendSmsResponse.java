package com.mmm.clout.memberservice.member.presentation.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class SendSmsResponse {

    private Long memberId;

    private String key;
}
