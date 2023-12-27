package com.mmm.clout.advertisementservice.apply.presentation.response;

import com.mmm.clout.advertisementservice.apply.application.reader.ApplicantListByCampaignReader;
import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import java.util.stream.Collectors;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ApplicantResponse {

    @Schema(description = "광고 캠페인 고유 식별자(id)")
    private Long campaignId;

    @Schema(description = "모집 인원")
    private Integer numberOfRecruiter; // 모집인원

    @Schema(description = "신청인원")
    private Integer numberOfApplicants; // 신청인원

    @Schema(description = "채택 인원")
    private Integer numberOfSelectedMembers; // 채택 인원

    @Schema(description = "희망 광고비")
    private Long hopeAdFee;

    @Schema(description = "신청 상태")
    private String applyStatus;

    @Schema(description = "클라우터 닉네임")
    private String nickname;

    @Schema(description = "클라우터 평균 별점")
    private Long clouterAvgStar;

    @Schema(description = "클라우터 sns 플랫폼 채널 리스트")
    private List<ChannelResponse> clouterChannelList;

    @Schema(description = "클라우터 id")
    private Long clouterId;

    @Schema(description = "지원 id")
    private Long applyId;

    public static List<ApplicantResponse> from(List<ApplicantListByCampaignReader> applicantList) {
        return applicantList.stream().map(
            a -> new ApplicantResponse(
                a.getCampaignId(),
                a.getNumberOfRecruiter(),
                a.getNumberOfApplicants(),
                a.getNumberOfSelectedMembers(),
                a.getHopeAdFee(),
                a.getApplyStatus(),
                a.getNickname(),
                a.getClouterAvgStar(),
                ChannelResponse.from(a.getClouterChannelList()),
                a.getClouterId(),
                    a.getApplyId()
            )
        ).collect(Collectors.toList());
    }

}