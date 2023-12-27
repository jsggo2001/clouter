package com.mmm.clout.pointservice.point.domain;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum PointCategory {

    /* DEAL */
    CONTRACT("계약"),
    CANCEL_CONTRACT("계약 취소"),
    CREATE_CAMPAIGN("캠페인 등록"),
    /* CHARGE */
    CHARGE("포인트 충전"),
    /* WITHDRAWAL */
    WITHDRAWAL("포인트 환전");


    private final String description;

    public static PointCategory convertToEnum(String categoryStr) {
        return PointCategory.valueOf(categoryStr.toUpperCase());
    }

}
