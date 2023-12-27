package com.mmm.clout.memberservice.member.presentation.response;

import com.mmm.clout.memberservice.common.Role;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class LoginReseponse {

    private Role memberRole;

    private Long memberId;
}
