package com.mmm.clout.advertisementservice.advertisements.application.facade;

import com.mmm.clout.advertisementservice.advertisements.application.*;
import com.mmm.clout.advertisementservice.advertisements.application.command.CreateCampaignCommand;
import com.mmm.clout.advertisementservice.advertisements.application.command.SearchCondition;
import com.mmm.clout.advertisementservice.advertisements.application.command.UpdateCampaignCommand;
import com.mmm.clout.advertisementservice.advertisements.application.reader.CampaignListReader;
import com.mmm.clout.advertisementservice.advertisements.application.reader.CampaignReader;
import com.mmm.clout.advertisementservice.advertisements.application.reader.FeignCampaignReader;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AdvertisementFacade {

    private final CreateCampaignProcessor createCampaignProcessor;
    private final UpdateCampaignProcessor updateCampaignProcessor;
    private final DeleteCampaignProcessor deleteCampaignProcessor;
    private final GetCampaignProcessor getCampaignProcessor;
    private final GetTop10CampaignListProcessor getTop10CampaignListProcessor;
    private final GetCampaignListByAdvertiser getCampaignListByAdvertiserProcessor;
    private final EndCampaignProcessor endCampaignProcessor;
    private final SearchCampaignListProcessor searchCampaignListProcessor;
    private final GetCampaignListByIdProcessor getCampaignListByIdProcessor;

    public Campaign create(CreateCampaignCommand command, List<MultipartFile> files, MultipartFile sign)throws Exception {
        return createCampaignProcessor.execute(command, files, sign);
    }

    public Campaign update(Long advertisementId, UpdateCampaignCommand command, List<MultipartFile> fileList) throws IOException {
        return updateCampaignProcessor.execute(advertisementId, command, fileList);
    }

    public void delete(Long advertisementId) {
        deleteCampaignProcessor.execute(advertisementId);
    }

    public CampaignReader get(Long advertisementId) {
        return getCampaignProcessor.execute(advertisementId);
    }

    public List<CampaignReader> getTop10() {
        return getTop10CampaignListProcessor.execute();
    }

    public CampaignListReader getAllCampaignsByAdvertisers(Long advertiserId, Pageable pageable) {
        return getCampaignListByAdvertiserProcessor.execute(advertiserId, pageable);
    }

    public Long end(Long advertisementId) {
        return endCampaignProcessor.execute(advertisementId);
    }


    public Page<CampaignReader> search(Pageable pageable, SearchCondition condition) {
        return searchCampaignListProcessor.execute(pageable, condition);
    }

    public List<FeignCampaignReader> getCampaignListByIdList(List<Long> adIdList) {
        return getCampaignListByIdProcessor.execute(adIdList);
    }
}
