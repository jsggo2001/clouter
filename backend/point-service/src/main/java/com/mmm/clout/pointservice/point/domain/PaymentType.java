package com.mmm.clout.pointservice.point.domain;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public enum PaymentType {

    KAKAO("카카오페이");

    private final String description;
}
