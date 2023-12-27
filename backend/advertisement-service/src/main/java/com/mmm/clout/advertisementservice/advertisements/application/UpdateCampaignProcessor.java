package com.mmm.clout.advertisementservice.advertisements.application;

import com.mmm.clout.advertisementservice.advertisements.application.command.UpdateCampaignCommand;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.advertisements.domain.exception.CampaignNotFoundException;
import com.mmm.clout.advertisementservice.advertisements.domain.repository.CampaignRepository;
import com.mmm.clout.advertisementservice.image.domain.FileUploader;
import com.mmm.clout.advertisementservice.image.domain.Image;
import com.mmm.clout.advertisementservice.image.domain.repository.ImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
public class UpdateCampaignProcessor {

    private final CampaignRepository campaignRepository;
    private final FileUploader fileUploader;
    private final ImageRepository imageRepository;
    @Transactional
    public Campaign execute(Long advertisementId, UpdateCampaignCommand command, List<MultipartFile> fileList) throws IOException {
        Campaign campaign = campaignRepository.findById(advertisementId)
            .orElseThrow(CampaignNotFoundException::new);

        campaign.update(
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
        //사진 검색해서 삭제

        List<Image> images = imageRepository.findByCampaignId(campaign.getId());
        images.stream()
                .map(v->fileUploader.delete(v.getPath()))
                .collect(Collectors.toList());
        //db에서 사진 삭제
        for(Image a : images){
            imageRepository.deleteImage(a.getId());
        }

        fileUploader.uploadList(fileList, campaign);
        return campaign;
    }
}
