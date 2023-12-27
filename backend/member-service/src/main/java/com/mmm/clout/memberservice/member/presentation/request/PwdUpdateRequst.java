package com.mmm.clout.memberservice.member.presentation.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@AllArgsConstructor
@Getter
public class PwdUpdateRequst {

    @Schema(description = "바꾸고자 하는 멤버의 id")
    @NotNull
    private Long id;

    @Schema(description = "바꾸고자 하는 비밀번호 값")
    @NotBlank
    private String pwd;

}
