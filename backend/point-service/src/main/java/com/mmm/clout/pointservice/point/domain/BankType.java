package com.mmm.clout.pointservice.point.domain;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public enum BankType {

    KYONGNAM_BANK("경남은행"),
    KWANGJU_BANK("광주은행"),
    KOOKMIN_BANK("국민은행"),
    INDUSTRIAL_BANK_OF_KOREA("기업은행"),
    NACF("농협중앙회"),
    REGIONAL_AGRICULTURAL_COOPERATIVES("지역농협·축협"),
    DAEGU_BANK("대구은행"),
    DAESHIN_SAVINGS_BANK("대신저축은행"),
    DEUTSCHE_BANK("도이치은행"),
    MORGAN_STANLEY_BANK("모건스탠리은행"),
    MITSUBISHI_BANK("미쓰비시은행"),
    BUSAN_BANK("부산은행"),
    NATIONAL_FORESTRY_COOPERATIVE_FEDERATION("산림조합중앙회"),
    KOREA_DEVELOPMENT_BANK("산업은행"),
    MUTUAL_SAVINGS_BANK("상호저축은행"),
    SAEMAUL_GEUMGO("새마을금고"),
    NATIONAL_FEDERATION_OF_FISHERIES_COOPERATIVES("수협"),
    CITIBANK("씨티은행"),
    SHINHAN_BANK("신한은행"),
    CREDIT_UNION("신협"),
    BANK_OF_AMERICA("아메리카은행"),
    KOREA_EXCHANGE_BANK("외환은행"),
    WOORI_BANK("우리은행"),
    POST_OFFICE("우체국"),
    WELCOME_SAVINGS_BANK("웰컴저축은행"),
    JEONBUK_BANK("전북은행"),
    JPMORGAN_CHASE_BANK("제이피모던체이스은행"),
    JEJU_BANK("제주은행"),
    KAKAOBANK("카카오뱅크"),
    K_BANK("케이뱅크"),
    HANA_BANK("하나은행"),
    THE_EXPORT_IMPORT_BANK_OF_KOREA("한국수출입은행"),
    BANK_OF_KOREA("한국은행"),
    HSBC("HSBC"),
    STANDARD_CHARTERED_BANK_KOREA("SC제일은행");

    private final String details;


    public static BankType converToEnum(String bankType) {
        return BankType.valueOf(bankType);
    }
}
