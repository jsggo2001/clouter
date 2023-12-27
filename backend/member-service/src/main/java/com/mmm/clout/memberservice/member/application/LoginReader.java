package com.mmm.clout.memberservice.member.application;

import com.mmm.clout.memberservice.common.Role;
import com.mmm.clout.memberservice.member.infrastructure.auth.dto.AuthDto;
import com.mmm.clout.memberservice.member.presentation.response.LoginReseponse;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class LoginReader {

    private AuthDto.TokenDto TokenDto;

    private Role memberRole;

    private Long memberId;

    public LoginReseponse toResponse() {
        return new LoginReseponse(
            this.memberRole,
            this.memberId
        );
    }
}
