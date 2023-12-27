package com.mmm.clout.contractservice.contract.domain.info;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ChannelInfo {

    private String name;

    private String platform;

    private String link;

    private String followerScale;

//    public ChannelResponse(ChannelReader channelReader) {
//        this.name = channelReader.getName();
//        this.platform = channelReader.getPlatform();
//        this.link = channelReader.getLink();
//        this.followerScale = channelReader.getFollowerScale();
//    }
}
