package com.mmm.clout.advertisementservice.common.exception;

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

    /*
     * Advertisement - campaign
     */

    CAMPAIGN_NOT_FOUND(HttpStatus.NOT_FOUND, "CAMPAIGN_ENTITY_NOT_FOUND", "등록되지 않은 광고 캠페인입니다."),
    END_RECUITS(HttpStatus.BAD_REQUEST, "END_RECRUITS", "모집 인원/날짜가 초과된 광고 캠페인입니다."),

    /*
     * Apply
     */
    ALREADY_ACCEPTED_APPLY(HttpStatus.BAD_REQUEST, "ALREADY_ACCEPTED_APPLY",
        "해당 광고 캠페인은 채택(계약) 완료 되었습니다."),
    ALREADY_CREATED_APPLY(HttpStatus.BAD_REQUEST, "ALREADY_ACCEPTED_APPLY", "이미 신청한 광고 캠페인입니다."),
    APPLY_NOT_FOUND(HttpStatus.NOT_FOUND, "APPLY_ENTITY_NOT_FOUND", "등록되지 않은 신청입니다."),
    APPLY_IS_CANCELED(HttpStatus.NOT_FOUND, "APPLY_IS_CANCELED", "신청자가 신청 취소하여 계약을 요청할 수 없습니다."),
    LACK_OF_POINT(HttpStatus.BAD_REQUEST, "LACK_OF_POINT", "차감할 포인트가 부족합니다.");;


    private final HttpStatus status;
    private final String code;
    private final String message;

    ErrorCode(HttpStatus status, String code, String message) {
        this.status = status;
        this.code = code;
        this.message = message;
    }
}
