package com.mmm.clout.advertisementservice.advertisements.application;

import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.advertisements.domain.exception.CampaignNotFoundException;
import com.mmm.clout.advertisementservice.advertisements.domain.repository.CampaignRepository;
import com.mmm.clout.advertisementservice.image.domain.FileUploader;
import com.mmm.clout.advertisementservice.image.domain.Image;
import com.mmm.clout.advertisementservice.image.domain.repository.ImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
public class DeleteCampaignProcessor {

    private final CampaignRepository campaignRepository;
    private final ImageRepository imageRepository;
    private final FileUploader fileUploader;

    @Transactional
    public void execute(Long advertisementId) {
        Campaign campaign = campaignRepository.findById(advertisementId)
            .orElseThrow(CampaignNotFoundException::new);

        List<Image> images = imageRepository.findByCampaignId(campaign.getId());
        images.stream()
                .map(v->fileUploader.delete(v.getPath()))
                .collect(Collectors.toList());
        for(Image a : images){
            imageRepository.deleteImage(a.getId());
        }

        campaign.softDelete();
    }
}
