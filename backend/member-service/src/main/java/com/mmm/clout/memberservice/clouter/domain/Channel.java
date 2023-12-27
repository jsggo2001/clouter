package com.mmm.clout.memberservice.clouter.domain;

import com.mmm.clout.memberservice.common.FollowerScale;
import com.mmm.clout.memberservice.common.Platform;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;

@Embeddable
@Getter
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Channel {

    @Column(length = 20)
    private String name;

    @Enumerated(EnumType.STRING)
    private Platform platform;

    @Column(length = 600)
    private String link;

    private Long followerScale;
}
