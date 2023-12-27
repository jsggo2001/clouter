package com.mmm.clout.memberservice.clouter.application.command;

import com.mmm.clout.memberservice.clouter.domain.Channel;
import com.mmm.clout.memberservice.common.FollowerScale;
import com.mmm.clout.memberservice.common.Platform;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ChannelCommand {

    private String name;

    private Platform platform;

    private String link;

    private Long followerScale;

    public Channel toValueType() {
        return new Channel(
            this.name,
            this.platform,
            this.link,
            this.followerScale
        );
    }
}
