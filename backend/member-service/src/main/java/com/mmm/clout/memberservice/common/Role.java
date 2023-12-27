package com.mmm.clout.memberservice.common;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum Role {
    ADMIN("ROLE_ADMIN", "관리자"),
    CLOUTER("ROLE_CLOUTER", "클라우터"),
    ADVERTISER("ROLE_ADVERTISER", "광고주");

    private final String key;
    private final String title;
}

