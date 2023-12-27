package com.mmm.clout.advertisementservice.apply.application;

import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.apply.application.reader.ApplyListByClouterReader;
import com.mmm.clout.advertisementservice.apply.domain.Apply;
import com.mmm.clout.advertisementservice.apply.domain.Apply.ApplyStatus;
import com.mmm.clout.advertisementservice.common.msa.info.AdvertiserInfo;
import com.mmm.clout.advertisementservice.common.msa.provider.MemberProvider;
import com.mmm.clout.advertisementservice.apply.domain.repository.ApplyRepository;
import com.querydsl.jpa.impl.JPAQuery;
import java.util.ArrayList;
import java.util.List;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.support.PageableExecutionUtils;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@RequiredArgsConstructor
public class ReadAllApplyProcessor {

    private final ApplyRepository applyRepository;
    private final MemberProvider advertiserInfoProvider;

    @Transactional
    public Page<ApplyListByClouterReader> execute(Pageable pageable, Long applicantId, ApplyStatus applyStatus) {
        List<Apply> applyList = applyRepository.getAllByStatus(pageable, applicantId, applyStatus);
        JPAQuery<Apply> countQuery = applyRepository.countByStatus(applicantId, applyStatus);

        List<ApplyListByClouterReader> content = new ArrayList<>();
        for (Apply apply: applyList) {
            Long advertiserId = apply.getCampaign().getAdvertiserId();
            AdvertiserInfo info = advertiserInfoProvider.getAdvertiserInfoByMemberId(advertiserId);
            Campaign campaign = apply.getCampaign().initialize();
            content.add(
                new ApplyListByClouterReader(
                        apply,
                        info.getCompanyInfo().getCompanyName(),
                        info.getAdvertiserAvgStar(),
                        campaign.getId(),
                        campaign.getAdPlatformList()
                )
            );
        }
        return PageableExecutionUtils.getPage(content, pageable, countQuery::fetchCount);
    }
}
