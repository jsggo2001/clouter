package com.mmm.clout.contractservice.common.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public enum ErrorCode {

    /*
     * Global
     */

    INTERNAL_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "GLOBAL_INTERNAL_SERVER_ERROR",
        "내부 서버 에러가 발생했습니다."),
    INVALID_INPUT_VALUE(HttpStatus.BAD_REQUEST, "GLOBAL_INVALID_INPUT_VALUE", "올바르지 않은 입력값입니다."),
    NOT_SUPPORTED_METHOD_ERROR(HttpStatus.METHOD_NOT_ALLOWED, "GLOBAL_NOT_SUPPORTED_METHOD_ERROR",
        "지원하지 않는 Method 요청입니다."),
    NOT_FOUND(HttpStatus.NOT_FOUND, "GLOBAL_404_ERROR", "404 에러입니다. 요청한 데이터를 서버가 찾을 수 없습니다."),
    METHOD_NOT_ALLOWED(HttpStatus.METHOD_NOT_ALLOWED, "GLOBAL_METHOD_NOT_ALLOWED",
        "잘못된 HTTP 메서드를 호출했습니다."),
    UN_AUTHENTICATED(HttpStatus.UNAUTHORIZED, "UN_AUTHENTICATED", "로그인 인증이 안된 유저입니다."),
    UN_AUTHORIZATION(HttpStatus.FORBIDDEN, "UN_AUTHORIZATION", "접근 권한이 없습니다."),
    ADVERTISER_ID_DUPLICATE(HttpStatus.CONFLICT, "ADVERTISER_ID_DUPLICATE", "현재 아이디는 다른 유저가 사용하고 있습니다."),
    CLOUTER_ID_DUPLICATE(HttpStatus.CONFLICT, "CLOUTER_ID_DUPLICATE", "현재 아이디는 다른 유저가 사용하고 있습니다."),
    NOT_F0UND_ADVERTISER(HttpStatus.NOT_FOUND, "NOT_F0UND_ADVERTISER", "존재하지 않는 유저 입니다."),
    NOT_F0UND_CLOUTER(HttpStatus.NOT_FOUND, "NOT_F0UND_CLOUTER", "존재하지 않는 유저 입니다."),
    NOT_FOUND_CONTRACT(HttpStatus.NOT_FOUND,"NOT_FOUND_CONTRACT" , "존재하지 않는 계약입니다."),
    DUPLICATE_CONTRACT(HttpStatus.CONFLICT, "DUPLICATE_CONTRACT", "이미 계약이 존재 합니다."),
    LACK_OF_POINT(HttpStatus.BAD_REQUEST, "LACK_OF_POINT", "차감할 포인트가 부족합니다.");


    private final HttpStatus status;
    private final String code;
    private final String message;

    ErrorCode(HttpStatus status, String code, String message) {
        this.status = status;
        this.code = code;
        this.message = message;
    }
}
