package com.mmm.clout.memberservice.clouter.presentation.response;

import com.mmm.clout.memberservice.clouter.application.reader.ChannelReader;
import com.mmm.clout.memberservice.clouter.domain.Channel;
import com.mmm.clout.memberservice.common.FollowerScale;
import com.mmm.clout.memberservice.common.Platform;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ChannelResponse {

    @Schema(description = "원하는 최대 금액")
    private String name;

    @Schema(description = "원하는 최대 금액")
    private Platform platform;

    @Schema(description = "원하는 최대 금액")
    private String link;

    @Schema(description = "원하는 최대 금액")
    private Long followerScale;

    public ChannelResponse(ChannelReader channelReader) {
        this.name = channelReader.getName();
        this.platform = channelReader.getPlatform();
        this.link = channelReader.getLink();
        this.followerScale = channelReader.getFollowerScale();
    }
}
