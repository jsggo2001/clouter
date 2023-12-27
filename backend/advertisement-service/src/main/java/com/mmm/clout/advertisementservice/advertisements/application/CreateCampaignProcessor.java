package com.mmm.clout.advertisementservice.advertisements.application;

import com.mmm.clout.advertisementservice.advertisements.application.command.CreateCampaignCommand;
import com.mmm.clout.advertisementservice.advertisements.domain.repository.CampaignRepository;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.advertisements.application.command.ReducePointCommand;
import com.mmm.clout.advertisementservice.common.msa.provider.PointProvider;
import com.mmm.clout.advertisementservice.image.domain.FileUploader;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RequiredArgsConstructor
public class CreateCampaignProcessor {

    private final CampaignRepository campaignRepository;
    private final PointProvider pointProvider;
    private final FileUploader fileUploader;

    @Transactional
    public Campaign execute(CreateCampaignCommand command, List<MultipartFile> files, MultipartFile sign) throws Exception{
        Campaign campaign = Campaign.create(
            command.getRegisterId(),
            command.getAdPlatformList(),
            command.getPrice(),
            command.getDetails(),
            command.getTitle(),
            command.getAdCategory(),
            command.isPriceChangeable(),
            command.isDeliveryRequired(),
            command.getNumberOfRecruiter(),
            command.getOfferingDetails(),
            command.getSellingLink(),
            command.getMinClouterAge(),
            command.getMaxClouterAge(),
            command.getMinFollower(),
            command.getRegionList()
        );

        reducePoint(command);
        fileUploader.uploadSign(sign, campaign);
        fileUploader.uploadList(files, campaign);
        return campaignRepository.save(campaign);
    }

    private void reducePoint(CreateCampaignCommand command) {
        ReducePointCommand request = new ReducePointCommand(command);
        pointProvider.reduce(request);
    }
}
