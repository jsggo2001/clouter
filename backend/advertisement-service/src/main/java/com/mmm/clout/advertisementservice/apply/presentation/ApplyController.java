package com.mmm.clout.advertisementservice.apply.presentation;

import com.mmm.clout.advertisementservice.apply.presentation.response.ApplyCheckResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.CustomPageResponse;
import com.mmm.clout.advertisementservice.apply.application.facade.ApplyFacade;
import com.mmm.clout.advertisementservice.apply.application.reader.ApplicantListByCampaignReader;
import com.mmm.clout.advertisementservice.apply.application.reader.ApplyListByClouterReader;
import com.mmm.clout.advertisementservice.apply.domain.Apply.ApplyStatus;
import com.mmm.clout.advertisementservice.apply.presentation.request.CreateApplyRequest;
import com.mmm.clout.advertisementservice.apply.presentation.response.ApplicantResponse;
import com.mmm.clout.advertisementservice.apply.presentation.response.ApplyMessageResponse;
import com.mmm.clout.advertisementservice.apply.presentation.response.CreateApplyResponse;
import com.mmm.clout.advertisementservice.apply.presentation.response.GetApplyByStatusResponse;
import com.mmm.clout.advertisementservice.common.docs.ApplyControllerDocs;
import java.util.List;
import java.util.stream.Collectors;
import javax.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1/applies")
@RequiredArgsConstructor
public class ApplyController implements ApplyControllerDocs {

    private final ApplyFacade applyFacade;

    /**
     * 캠페인 신청
     */

    @PostMapping
    public ResponseEntity<CreateApplyResponse> createApply(
        @RequestBody @Valid CreateApplyRequest createApplyRequest
    ) {
        CreateApplyResponse result = CreateApplyResponse.from(
            applyFacade.create(createApplyRequest.toCommand()));
        return new ResponseEntity<>(result, HttpStatus.CREATED);
    }

    /**
     * 클라우터가 신청한 캠페인을 취소하기
     */
    @PostMapping("/{applyId}/cancel")
    public ResponseEntity<String> cancelApply(
        @PathVariable Long applyId
    ) {
        applyFacade.cancel(applyId);
        return new ResponseEntity<>("신청 취소 완료", HttpStatus.OK);
    }


    /**
     * 클라우터가 신청한 캠페인 목록 (종류 존재)
     */
    @GetMapping("/clouters")
    public ResponseEntity<CustomPageResponse<GetApplyByStatusResponse>> getApplyListByStatus(
        @RequestParam Long clouterId,
        @RequestParam ApplyStatus type,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int size
    ) {
        Page<ApplyListByClouterReader> result =
            applyFacade.getAllByApplyStatus(PageRequest.of(page, size), clouterId, type);

        List<GetApplyByStatusResponse> content = result.stream().map(
            GetApplyByStatusResponse::from
        ).collect(Collectors.toList());

        return new ResponseEntity<>(
            new CustomPageResponse<>(
                content,
                result.getNumber(),
                result.getSize(),
                result.getTotalPages(),
                result.getTotalElements()
            ), HttpStatus.OK);
    }

    /**
     * 광고주가) 해당 광고 신청자 목록 조회
     */
    @GetMapping("/advertisers")
    public ResponseEntity<CustomPageResponse<ApplicantResponse>> getApplicantList(
        @RequestParam Long advertisementId,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int size
    ) {
        Page<ApplicantListByCampaignReader> result = applyFacade.getApplicantList(
            PageRequest.of(page, size), advertisementId);
        List<ApplicantResponse> content =
            ApplicantResponse.from(result.getContent());

        return new ResponseEntity<>(
            new CustomPageResponse<>(
                content,
                result.getNumber(),
                result.getSize(),
                result.getTotalPages(),
                result.getTotalElements()
            ), HttpStatus.OK);
    }

    /**
     * 신청자 한마디 조회
     */
    @GetMapping("/{applyId}/msg")
    public ResponseEntity<ApplyMessageResponse> getApplyMsg(
        @PathVariable Long applyId
    ) {
        String result = applyFacade.getMessage(applyId);

        return new ResponseEntity<>(
            new ApplyMessageResponse(applyId, result), HttpStatus.OK
        );
    }

    /**
     * 채택 -> 계약 생성
     */
    @PostMapping("/{applyId}/selection")
    public ResponseEntity<Void> selectForContract(
        @PathVariable Long applyId
    ) {
        applyFacade.selectForContract(applyId);
        return new ResponseEntity<>(HttpStatus.OK);
    }


    /**
     * 광고 어플라이 여부 리스폰스 api
     */
    @GetMapping("/applyCheck")
    public ResponseEntity<ApplyCheckResponse> applycheck(
        @RequestParam("advertisementId") Long advertisementId,
        @RequestParam("clouterId") Long clouterId
    ) {

        ApplyCheckResponse response = ApplyCheckResponse.from(
            applyFacade.applyCheck(advertisementId, clouterId)
        );
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
