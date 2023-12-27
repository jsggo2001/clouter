package com.mmm.clout.memberservice.clouter.presentation.request;

import com.mmm.clout.memberservice.clouter.application.command.ChannelCommand;
import com.mmm.clout.memberservice.common.FollowerScale;
import com.mmm.clout.memberservice.common.Platform;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Getter
@AllArgsConstructor
public class ChannelRequest {

    @NotBlank
    @Schema(description = "채널 이름")
    @Size(max = 20)
    private String name;

    @NotNull
    @Schema(description = "자신의 플랫폼", defaultValue = "INSTAGRAM")
    private Platform platform;

    @NotBlank
    @Schema(description = "채널 링크")
    @Size(max = 500)
    private String link;

    @NotNull
    @Schema(description = "채널의 구독자 규모")
    private Long followerScale;

    public ChannelCommand toCommand() {
        return new ChannelCommand(
            this.name,
            this.platform,
            this.link,
            this.followerScale
        );
    }

}
