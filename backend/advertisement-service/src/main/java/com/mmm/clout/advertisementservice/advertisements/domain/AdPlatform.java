package com.mmm.clout.advertisementservice.advertisements.domain;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public enum AdPlatform {

    ALL("전체"),
    INSTAGRAM("인스타그램"),
    TIKTOK("틱톡"),
    YOUTUBE("유튜브");

    private final String details;

}
