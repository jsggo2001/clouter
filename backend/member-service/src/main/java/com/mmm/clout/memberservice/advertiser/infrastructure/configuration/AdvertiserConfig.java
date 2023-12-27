package com.mmm.clout.memberservice.advertiser.infrastructure.configuration;

import com.mmm.clout.memberservice.advertiser.application.CreateAdvertiserProcessor;
import com.mmm.clout.memberservice.advertiser.application.SelectAdvertiserProcessor;
import com.mmm.clout.memberservice.advertiser.application.UpdateAdvertiserProcessor;
import com.mmm.clout.memberservice.advertiser.domain.repository.AdvertiserRepository;
import com.mmm.clout.memberservice.member.domain.provider.PointProvider;
import com.mmm.clout.memberservice.member.domain.repository.MemberRepository;
import com.mmm.clout.memberservice.star.domain.repository.StarRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Configuration
public class AdvertiserConfig {
    @Bean
    public CreateAdvertiserProcessor createAdvertiserProcessor(
            AdvertiserRepository advertiserRepository,
            MemberRepository memberRepository,
            BCryptPasswordEncoder encoder,
            StarRepository starRepository,
            PointProvider pointProvider

    ) {
        return new CreateAdvertiserProcessor(advertiserRepository, memberRepository, encoder, starRepository, pointProvider);
    }

    @Bean
    public UpdateAdvertiserProcessor updateAdvertiserProcessor(
            AdvertiserRepository advertiserRepository, BCryptPasswordEncoder encoder
    ) {
        return new UpdateAdvertiserProcessor(advertiserRepository, encoder);
    }

    @Bean
    public SelectAdvertiserProcessor selectAdvertiserProcessor(
            AdvertiserRepository advertiserRepository, BCryptPasswordEncoder encoder
    ) {
        return new SelectAdvertiserProcessor(advertiserRepository);
    }
}
