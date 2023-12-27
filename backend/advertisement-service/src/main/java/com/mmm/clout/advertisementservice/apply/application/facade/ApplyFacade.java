package com.mmm.clout.advertisementservice.apply.application.facade;

import com.mmm.clout.advertisementservice.apply.application.*;
import com.mmm.clout.advertisementservice.apply.application.command.CreateApplyCommand;
import com.mmm.clout.advertisementservice.apply.application.reader.ApplicantListByCampaignReader;
import com.mmm.clout.advertisementservice.apply.application.reader.ApplyCheckReader;
import com.mmm.clout.advertisementservice.apply.application.reader.ApplyListByClouterReader;
import com.mmm.clout.advertisementservice.apply.domain.Apply;
import com.mmm.clout.advertisementservice.apply.domain.Apply.ApplyStatus;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ApplyFacade {

    private final CreateApplyProcessor createApplyProcessor;
    private final CancelApplyProcessor cancelApplyProcessor;
    private final ReadAllApplyProcessor readAllApplyProcessor;
    private final ReadApplicantsByCampaignProcessor readApplicantsByCampaignProcessor;
    private final GetApplyProcessor getApplyProcessor;
    private final SelectApplyForContractProcessor selectApplyForContractProcessor;
    private final CheckApplyProcessor checkApplyProcessor;

    public Apply create(CreateApplyCommand command) {
        return createApplyProcessor.execute(command);
    }

    public void cancel(Long applyId) {
        cancelApplyProcessor.execute(applyId);
    }

    public Page<ApplyListByClouterReader> getAllByApplyStatus(Pageable pageable, Long clouterId, ApplyStatus type) {
        return readAllApplyProcessor.execute(pageable, clouterId, type);
    }

    public Page<ApplicantListByCampaignReader> getApplicantList(Pageable pageable, Long advertisementId) {
        return readApplicantsByCampaignProcessor.execute(pageable, advertisementId);
    }

    public String getMessage(Long applyId) {
        return getApplyProcessor.execute(applyId).getApplyMessage();
    }

    public void selectForContract(Long applyId) {
        selectApplyForContractProcessor.execute(applyId);
    }

    public ApplyCheckReader applyCheck(Long advertisementId, Long clouterId) {
        return checkApplyProcessor.execute(advertisementId, clouterId);
    }
}
