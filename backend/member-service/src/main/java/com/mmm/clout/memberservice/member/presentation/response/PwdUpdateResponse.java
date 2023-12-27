package com.mmm.clout.memberservice.member.presentation.response;

import com.mmm.clout.memberservice.member.domain.Member;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class PwdUpdateResponse {

    @Schema(description = "수정된 멤버 id")
    private Long updatedMemberId;

    public static PwdUpdateResponse from(Member member) {
        return new PwdUpdateResponse(member.getId());
    }

}
