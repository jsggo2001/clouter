package com.mmm.clout.memberservice.bookmark.application;

import com.mmm.clout.memberservice.advertiser.domain.Advertiser;
import com.mmm.clout.memberservice.advertiser.domain.repository.AdvertiserRepository;
import com.mmm.clout.memberservice.bookmark.application.reader.CampaignReader;
import com.mmm.clout.memberservice.bookmark.domain.Bookmark;
import com.mmm.clout.memberservice.bookmark.domain.info.CampaignInfo;
import com.mmm.clout.memberservice.bookmark.domain.provider.AdvertisementProvider;
import com.mmm.clout.memberservice.bookmark.domain.repository.BookmarkRepository;
import com.mmm.clout.memberservice.clouter.domain.Clouter;
import com.mmm.clout.memberservice.clouter.domain.repository.ClouterRepository;
import com.mmm.clout.memberservice.member.domain.repository.MemberRepository;
import com.mmm.clout.memberservice.member.infrastructure.auth.service.MemberService;
import com.querydsl.jpa.impl.JPAQuery;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.support.PageableExecutionUtils;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@RequiredArgsConstructor
public class SelectAdByMemberIdProcessor {

    private final BookmarkRepository bookmarkRepository;
    private final AdvertisementProvider advertisementProvider;
    private final AdvertiserRepository advertiserRepository;

    @Transactional
    public Page<CampaignReader> execute(Long memberId, Pageable pageable) {
        List<Long> AdidList = bookmarkRepository.findByMemberId(memberId, pageable).stream().map(v -> v.getTargetId()).collect(Collectors.toList());
        List<CampaignInfo> campaignInfos = advertisementProvider.getCampaignListById(AdidList).getBody();
        List<Long> clIdLists = campaignInfos.stream().map(v -> v.getRegisterId()).collect(Collectors.toList());
        List<Advertiser> advertisers = advertiserRepository.findByIdIn(clIdLists);
        Map<Long, Advertiser> advertiserMap = advertisers.stream().collect(Collectors.toMap(Advertiser::getId, ad -> ad));

        List<CampaignReader> result = IntStream.range(0, campaignInfos.size()).mapToObj(
            i -> new CampaignReader(campaignInfos.get(i), advertiserMap.get(campaignInfos.get(i).getRegisterId()))
        ).collect(Collectors.toList());

        JPAQuery<Bookmark> countQuery = bookmarkRepository.findByMemberIdForCount(memberId);

        return PageableExecutionUtils.getPage(result, pageable, countQuery::fetchCount);
    }
}
