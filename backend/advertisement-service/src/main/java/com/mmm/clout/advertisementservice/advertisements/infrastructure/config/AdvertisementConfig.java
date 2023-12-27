package com.mmm.clout.advertisementservice.advertisements.infrastructure.config;

import com.mmm.clout.advertisementservice.advertisements.application.CreateCampaignProcessor;
import com.mmm.clout.advertisementservice.advertisements.application.DeleteCampaignProcessor;
import com.mmm.clout.advertisementservice.advertisements.application.EndCampaignProcessor;
import com.mmm.clout.advertisementservice.advertisements.application.GetCampaignListByAdvertiser;
import com.mmm.clout.advertisementservice.advertisements.application.GetCampaignListByIdProcessor;
import com.mmm.clout.advertisementservice.advertisements.application.GetCampaignProcessor;
import com.mmm.clout.advertisementservice.advertisements.application.GetTop10CampaignListProcessor;
import com.mmm.clout.advertisementservice.advertisements.application.SearchCampaignListProcessor;
import com.mmm.clout.advertisementservice.advertisements.application.UpdateCampaignProcessor;
import com.mmm.clout.advertisementservice.advertisements.domain.repository.CampaignRepository;
import com.mmm.clout.advertisementservice.apply.domain.repository.ApplyRepository;
import com.mmm.clout.advertisementservice.common.msa.provider.MemberProvider;
import com.mmm.clout.advertisementservice.common.msa.provider.PointProvider;
import com.mmm.clout.advertisementservice.image.domain.FileUploader;
import com.mmm.clout.advertisementservice.image.domain.Image;
import com.mmm.clout.advertisementservice.image.domain.repository.AdvertiseSignRepository;
import com.mmm.clout.advertisementservice.image.domain.repository.ImageRepository;
import com.querydsl.jpa.impl.JPAQueryFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AdvertisementConfig {

    @Bean
    public CreateCampaignProcessor createAdvertisementProcessor(
            @Qualifier("CampaignRepository") CampaignRepository campaignRepository,
            PointProvider pointProvider,
            FileUploader fileUploader
            ) {
        return new CreateCampaignProcessor(campaignRepository, pointProvider, fileUploader);
    }

    @Bean
    public UpdateCampaignProcessor updateCampaignProcessor(
        @Qualifier("CampaignRepository") CampaignRepository campaignRepository,
        FileUploader fileUploader,
        ImageRepository imageRepository
    ) {
        return new UpdateCampaignProcessor(campaignRepository, fileUploader, imageRepository);
    }

    @Bean
    public DeleteCampaignProcessor deleteCampaignProcessor(
        @Qualifier("CampaignRepository") CampaignRepository campaignRepository,
        FileUploader fileUploader,
        ImageRepository imageRepository
    ) {
        return new DeleteCampaignProcessor(campaignRepository, imageRepository, fileUploader);
    }

    @Bean
    public GetCampaignProcessor getCampaignProcessor(
        @Qualifier("CampaignRepository") CampaignRepository campaignRepository,
        MemberProvider memberProvider,
        ImageRepository imageRepository,
        AdvertiseSignRepository advertiseSignRepository

    ) {
        return new GetCampaignProcessor(
            campaignRepository,
            memberProvider,
            imageRepository,
            advertiseSignRepository
        );
    }

    @Bean
    public GetTop10CampaignListProcessor getTop10CampaignListProcessor(
        @Qualifier("CampaignRepository") CampaignRepository campaignRepository,
        MemberProvider memberProvider,
        ImageRepository imageRepository,
        AdvertiseSignRepository advertiseSignRepository
    ) {
        return new GetTop10CampaignListProcessor(
            campaignRepository,
            memberProvider,
            imageRepository,
            advertiseSignRepository
        );
    }

    @Bean
    public GetCampaignListByAdvertiser getCampaignListByAdvertiser(
        @Qualifier("CampaignRepository") CampaignRepository campaignRepository,
        MemberProvider memberProvider,
        ImageRepository imageRepository,
        AdvertiseSignRepository advertiseSignRepository
    ) {
        return new GetCampaignListByAdvertiser(
            campaignRepository,
            memberProvider,
            imageRepository,
            advertiseSignRepository
        );
    }

    @Bean
    public EndCampaignProcessor endCampaignProcessor(
        @Qualifier("CampaignRepository") CampaignRepository campaignRepository,
        ApplyRepository applyRepository
    ) {
        return new EndCampaignProcessor(campaignRepository, applyRepository);
    }

    @Bean
    public SearchCampaignListProcessor searchCampaignListProcessor(
        @Qualifier("CampaignRepository") CampaignRepository campaignRepository,
        MemberProvider memberProvider,
        ImageRepository imageRepository,
        AdvertiseSignRepository advertiseSignRepository
    ) {
        return new SearchCampaignListProcessor(
            campaignRepository,
            memberProvider,
            imageRepository,
            advertiseSignRepository
        );
    }

    @Bean
    public GetCampaignListByIdProcessor getCampaignListByIdProcessor(
        @Qualifier("CampaignRepository") CampaignRepository campaignRepository,
        ImageRepository imageRepository
    ) {
        return new GetCampaignListByIdProcessor(campaignRepository, imageRepository);
    }
}
