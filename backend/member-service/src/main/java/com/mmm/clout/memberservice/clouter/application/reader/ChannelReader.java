package com.mmm.clout.memberservice.clouter.application.reader;

import com.mmm.clout.memberservice.clouter.domain.Channel;
import com.mmm.clout.memberservice.common.FollowerScale;
import com.mmm.clout.memberservice.common.Platform;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ChannelReader {

    @Schema(description = "원하는 최대 금액")
    private String name;

    @Schema(description = "플랫폼")
    private Platform platform;

    @Schema(description = "채널 링크")
    private String link;

    @Schema(description = "팔로워 규모")
    private Long followerScale;

    public ChannelReader(Channel channel) {
        this.name = channel.getName();
        this.platform = channel.getPlatform();
        this.link = channel.getLink();
        this.followerScale = channel.getFollowerScale();
    }
}
