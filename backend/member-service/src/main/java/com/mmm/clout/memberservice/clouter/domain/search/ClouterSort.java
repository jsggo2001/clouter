package com.mmm.clout.memberservice.clouter.domain.search;

import com.querydsl.core.types.Order;

public enum ClouterSort {

    COUNTOFCONTRACT("countOfContract", Order.DESC), // 계약 건수
    COST("minCost", Order.ASC),     // 최소 광고비
    SCORE("avgScore", Order.DESC);  // 평균 평점 순

    private final String property;
    private final Order order;

    ClouterSort(String property, Order order) {
        this.property = property;
        this.order = order;
    }

    public String getProperty() {
        return property;
    }

    public Order getOrder() {
        return order;
    }

}
