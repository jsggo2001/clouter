package com.mmm.clout.memberservice.bookmark.presentation.request;

import com.mmm.clout.memberservice.bookmark.application.command.CreateClouterBookmarkCommand;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

import javax.validation.constraints.NotNull;

@AllArgsConstructor
@Getter
public class CreateClouterBookmarkRequest {

    @NotNull
    @Schema(description = "북마크를 하는 멤버 아이디")
    private Long memberId;

    @NotNull
    @Schema(description = "북마크를 당하는 컨텐츠 객체 아이디")
    private Long targetId;

    public CreateClouterBookmarkCommand toCommand() {
        return new CreateClouterBookmarkCommand(
            this.memberId,
            this.targetId
        );
    }
}
