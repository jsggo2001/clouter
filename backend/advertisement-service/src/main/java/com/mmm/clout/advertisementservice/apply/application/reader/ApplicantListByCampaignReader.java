package com.mmm.clout.advertisementservice.apply.application.reader;

import com.mmm.clout.advertisementservice.common.msa.info.ChannelInfo;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ApplicantListByCampaignReader {

    private Long campaignId;

    private Integer numberOfRecruiter; // 모집인원

    private Integer numberOfApplicants; // 신청인원

    private Integer numberOfSelectedMembers; // 채택 인원

    private Long hopeAdFee;

    private String applyStatus;

    private String nickname;

    private Long clouterAvgStar;

    private List<ChannelInfo> clouterChannelList;

    private Long clouterId;

    private Long applyId;
}
