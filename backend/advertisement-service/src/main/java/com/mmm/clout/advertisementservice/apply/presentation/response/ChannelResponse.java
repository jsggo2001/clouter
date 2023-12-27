package com.mmm.clout.advertisementservice.apply.presentation.response;

import com.mmm.clout.advertisementservice.common.msa.info.ChannelInfo;
import java.util.List;
import java.util.stream.Collectors;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ChannelResponse {

    private String name;

    private String platform; // enum -> string

    private String link;

    private String followerScale; // enum -> string

    public static List<ChannelResponse> from(List<ChannelInfo> clouterChannelList) {
        return clouterChannelList.stream().map(
            c -> new ChannelResponse(
                c.getName(),
                c.getPlatform(),
                c.getLink(),
                c.getFollowerScale()
            )
        ).collect(Collectors.toList());
    }

}
