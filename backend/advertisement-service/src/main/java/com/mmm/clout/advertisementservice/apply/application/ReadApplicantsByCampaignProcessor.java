package com.mmm.clout.advertisementservice.apply.application;

import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.apply.application.reader.ApplicantListByCampaignReader;
import com.mmm.clout.advertisementservice.apply.domain.Apply;
import com.mmm.clout.advertisementservice.common.msa.info.ClouterInfo;
import com.mmm.clout.advertisementservice.common.msa.provider.MemberProvider;
import com.mmm.clout.advertisementservice.apply.domain.repository.ApplyRepository;
import com.querydsl.jpa.impl.JPAQuery;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.support.PageableExecutionUtils;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
public class ReadApplicantsByCampaignProcessor {

    private final ApplyRepository applyRepository;
    private final MemberProvider clouterProvider;

    @Transactional
    public Page<ApplicantListByCampaignReader> execute(Pageable pageable, Long advertisementId) {

        List<Apply> applyList = applyRepository.findApplicantList(advertisementId, pageable);
        applyList = applyList.stream().filter(v -> v.getApplyStatus() != Apply.ApplyStatus.CANCEL).collect(Collectors.toList());

        JPAQuery<Apply> countQuery = applyRepository.countByAdvertisement(advertisementId);

        List<ApplicantListByCampaignReader> content = new ArrayList<>();
        for (Apply apply: applyList) {
            Long applicantId = apply.getApplicant().getApplicantId();
            ClouterInfo info = clouterProvider.getClouterInfoByMemberId(applicantId);
            Campaign campaign = apply.getCampaign();
            content.add(
                new ApplicantListByCampaignReader(
                    campaign.getId(),
                    campaign.getNumberOfRecruiter(),
                    campaign.getNumberOfApplicants(),
                    campaign.getNumberOfSelectedMembers(),
                    apply.getHopeAdFee(),
                    apply.getApplyStatus().toString(),
                    info.getNickName(),
                    info.getAvgScore(),
                    info.getChannelList(),
                    apply.getApplicant().getApplicantId(),
                        apply.getId()
                )
            );
        }

        return PageableExecutionUtils.getPage(content, pageable, countQuery::fetchCount);
    }
}
