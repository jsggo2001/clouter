package com.mmm.clout.memberservice.bookmark.infrastructure.configuration;

import com.mmm.clout.memberservice.advertiser.domain.repository.AdvertiserRepository;
import com.mmm.clout.memberservice.bookmark.application.*;
import com.mmm.clout.memberservice.bookmark.domain.provider.AdvertisementProvider;
import com.mmm.clout.memberservice.bookmark.domain.repository.BookmarkRepository;
import com.mmm.clout.memberservice.clouter.domain.repository.ClouterRepository;
import com.mmm.clout.memberservice.image.domain.repository.ImageRepository;
import com.mmm.clout.memberservice.member.domain.Member;
import com.mmm.clout.memberservice.member.domain.repository.MemberRepository;
import com.mmm.clout.memberservice.member.infrastructure.auth.service.MemberService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class BookmarkConfig {

    @Bean
    public CheckBookmarkProcessor checkBookmarkProcessor(
        BookmarkRepository bookmarkRepository,
        MemberRepository memberRepository
    ) {
        return new CheckBookmarkProcessor(bookmarkRepository, memberRepository);
    }

    @Bean
    public CreateAdBookmarkProcessor createAdBookmarkProcessor(
        BookmarkRepository bookmarkRepository,
        MemberRepository memberRepository
    ) {
        return new CreateAdBookmarkProcessor(bookmarkRepository, memberRepository);
    }

    @Bean
    public CreateClouterBookmarkProcessor createClouterBookmarkProcessor(
        BookmarkRepository bookmarkRepository,
        MemberRepository memberRepository
    ) {
        return new CreateClouterBookmarkProcessor(bookmarkRepository, memberRepository);
    }

    @Bean
    public DeleteBookmarkProcessor deleteBookmarkProcessor(
        BookmarkRepository bookmarkRepository,
        MemberRepository memberRepository
    ) {
        return new DeleteBookmarkProcessor(bookmarkRepository, memberRepository);
    }

    @Bean
    public SelectAdByMemberIdProcessor selectAdByMemberIdProcessor(
        BookmarkRepository bookmarkRepository,
        AdvertisementProvider advertisementProvider,
        AdvertiserRepository advertiserRepository
    ) {
        return new SelectAdByMemberIdProcessor(bookmarkRepository, advertisementProvider, advertiserRepository);
    }

    @Bean
    public SelectClouterByMemberIdProcessor selectClouterByMemberIdProcessor(
        BookmarkRepository bookmarkRepository,
        ClouterRepository clouterRepository,
        ImageRepository imageRepository
    ) {
        return new SelectClouterByMemberIdProcessor(bookmarkRepository, clouterRepository, imageRepository);
    }
}
