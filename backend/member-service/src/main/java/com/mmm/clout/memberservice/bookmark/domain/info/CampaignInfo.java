package com.mmm.clout.memberservice.bookmark.domain.info;

import com.mmm.clout.memberservice.image.presentation.ImageResponse;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@AllArgsConstructor
public class CampaignInfo {

    private Long campaignId;

    private List<String> adPlatformList;

    private Long price;

    private String details;

    private LocalDateTime deletedAt;

    private String title;

    private String adCategory; // 광고 카테고리

    private Boolean isPriceChangeable; // 광고비 협의 여부

    private Boolean isDeliveryRequired; // 배송 여부

    private Integer numberOfRecruiter; // 모집인원

    private Integer numberOfApplicants; // 신청인원

    private Integer numberOfSelectedMembers; // 채택 인원

    private String offeringDetails; // 제공 내역 설명

    private String sellingLink; // 판매처 링크 (선택사항)

    private LocalDate applyStartDate; // 모집 시작 날짜

    private LocalDate applyEndDate; // 모집 종료 날짜

    private Integer minClouterAge; // 최소 클라우터 나이

    private Integer maxClouterAge; // 최대 클라우터 나이

    private Integer minFollower; // 최소 팔로워 수

    private Boolean isEnded; // 모집 종료 여부

    private Long registerId;

    private List<ImageResponse> imageList;
}
