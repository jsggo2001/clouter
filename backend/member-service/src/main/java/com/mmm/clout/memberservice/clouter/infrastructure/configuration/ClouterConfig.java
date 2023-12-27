package com.mmm.clout.memberservice.clouter.infrastructure.configuration;

import com.mmm.clout.memberservice.clouter.application.*;
import com.mmm.clout.memberservice.clouter.domain.repository.ClouterRepository;
import com.mmm.clout.memberservice.image.domain.FileUploader;
import com.mmm.clout.memberservice.image.domain.Image;
import com.mmm.clout.memberservice.image.domain.repository.ImageRepository;
import com.mmm.clout.memberservice.member.domain.provider.PointProvider;
import com.mmm.clout.memberservice.member.domain.repository.MemberRepository;
import com.mmm.clout.memberservice.star.domain.repository.StarRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.io.IOException;

@Configuration
public class ClouterConfig {

    @Bean
    public SelectClouterForContractProcessor selectClouterForContractProcessor(
        ClouterRepository clouterRepository
    ) {
        return new SelectClouterForContractProcessor(clouterRepository);
    }

    @Bean
    public SelectTop10ClouterProcessor selectTop10ClouterProcessor(
        ClouterRepository clouterRepository,
        ImageRepository imageRepository
    ) {
        return new SelectTop10ClouterProcessor(clouterRepository, imageRepository);
    }

    @Bean
    public CreateClouterProcessor createClouterProcessor(
        ClouterRepository clouterRepository,
        MemberRepository memberRepository,
        BCryptPasswordEncoder encoder,
        StarRepository starRepository,
        PointProvider pointProvider,
        FileUploader fileUploader
    ) {
        return new CreateClouterProcessor(clouterRepository, memberRepository, encoder,
            starRepository, pointProvider, fileUploader);
    }

    @Bean
    public UpdateClouterProcessor updateClouterProcessor (
        ClouterRepository clouterRepository, BCryptPasswordEncoder encoder,
        ImageRepository imageRepository,
        FileUploader fileUploader
    ) throws IOException {
        return new UpdateClouterProcessor(clouterRepository, encoder, imageRepository, fileUploader);
    }

    @Bean
    public SelectClouterProcessor selectClouterProcessor(
        ClouterRepository clouterRepository,
        ImageRepository imageRepository
    ) {
        return new SelectClouterProcessor(clouterRepository, imageRepository);
    }

    @Bean
    public SearchClouterListProcessor searchClouterListProcessor(
        ClouterRepository clouterRepository,
        ImageRepository imageRepository
    ) {
        return new SearchClouterListProcessor(clouterRepository, imageRepository);
    }
}
