package com.mmm.clout.pointservice.point.domain;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum PointStatus {

    PLUS("+"), MINUS("-");

    private final String description;

}
