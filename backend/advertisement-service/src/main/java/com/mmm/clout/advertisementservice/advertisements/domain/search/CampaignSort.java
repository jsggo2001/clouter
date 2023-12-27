package com.mmm.clout.advertisementservice.advertisements.domain.search;

import com.querydsl.core.types.Order;

public enum CampaignSort {

    POPULARITY("numberOfApplicants", Order.DESC), // 인기순 (신청자수를 내림차순으로)
    NEWEST("createdAt", Order.DESC),     // 최신순 (생성 날짜 내림차순)
    DEADLINE("applyEndDate", Order.ASC);  // 마감임박순 (신청 마감 날짜 오름차순)

    private final String property;
    private final Order order;

    CampaignSort(String property, Order order) {
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
