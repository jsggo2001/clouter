package com.mmm.clout.advertisementservice.advertisements.persentation;

import com.mmm.clout.advertisementservice.advertisements.application.command.SearchCondition;
import com.mmm.clout.advertisementservice.advertisements.application.facade.AdvertisementFacade;
import com.mmm.clout.advertisementservice.advertisements.application.reader.CampaignListReader;
import com.mmm.clout.advertisementservice.advertisements.application.reader.CampaignReader;
import com.mmm.clout.advertisementservice.advertisements.domain.AdCategory;
import com.mmm.clout.advertisementservice.advertisements.domain.AdPlatform;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.advertisements.domain.Region;
import com.mmm.clout.advertisementservice.advertisements.domain.search.CampaignSort;
import com.mmm.clout.advertisementservice.advertisements.persentation.request.CreateCampaignRequest;
import com.mmm.clout.advertisementservice.advertisements.persentation.request.UpdateCampaignRequest;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.CampaignReaderResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.CampaignResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.CreateCampaignResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.CustomPageResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.DeleteCampaignResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.EndedCampaignResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.GetCampaignAndAdvertiserResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.GetCampainListByAdvertiserResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.GetTop10CampainListResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.UpdateCampaignResponse;
import com.mmm.clout.advertisementservice.common.docs.AdvertisementControllerDocs;
import com.mmm.clout.advertisementservice.common.msa.info.AdvertiserInfo;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import javax.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/v1/advertisements")
@RequiredArgsConstructor
public class AdvertisementController implements AdvertisementControllerDocs {

    private final AdvertisementFacade advertisementFacade;


    /**
     * 광고 캠페인 등록
     */
    @PostMapping(consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    public ResponseEntity<CreateCampaignResponse> createCampaign(
        @RequestPart @Valid CreateCampaignRequest createCampaignRequest,
        @RequestPart(value = "files") List<MultipartFile> fileList
    )throws Exception {
        MultipartFile sign = fileList.remove(0);
        CreateCampaignResponse result = CreateCampaignResponse.from(
            advertisementFacade.create(createCampaignRequest.toCommand(), fileList, sign)
        );
        return new ResponseEntity<>(result, HttpStatus.CREATED);
    }

    /**
     * 캠페인 수정
     */
    @PostMapping(value = "/{advertisementId}/modify", consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    public ResponseEntity<UpdateCampaignResponse> updateCampaign(
        @PathVariable Long advertisementId,
        @RequestPart @Valid UpdateCampaignRequest updateCampaignRequest,
        @RequestPart(value = "files") List<MultipartFile> fileList
    ) throws Exception {
        UpdateCampaignResponse result = UpdateCampaignResponse.from(
            advertisementFacade.update(advertisementId, updateCampaignRequest.toCommand(), fileList));
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    /**
     * 캠페인 삭제 (soft delete)
     */

    @PostMapping("/{advertisementId}")
    public ResponseEntity<DeleteCampaignResponse> deleteCampaign(
        @PathVariable Long advertisementId
    ) {
        advertisementFacade.delete(advertisementId);
        DeleteCampaignResponse result = DeleteCampaignResponse.from(advertisementId);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    /**
     * 캠페인 캠페인 상세 조회 (광고주 정보 포함)
     */
    @GetMapping("/{advertisementId}")
    public ResponseEntity<GetCampaignAndAdvertiserResponse> getCampaignDetails(
        @PathVariable Long advertisementId
    ) {
        GetCampaignAndAdvertiserResponse result = GetCampaignAndAdvertiserResponse.from(
            advertisementFacade.get(advertisementId)
        );
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    /**
     * 인기 있는 광고 리스트 (10개) 조회 (신청자 수 많은 순 / 모집기간 내 / 우선순위가 같을경우, 최신순)
     */
    @GetMapping("/top10")
    public ResponseEntity<GetTop10CampainListResponse> getTop10Campaigns() {
        GetTop10CampainListResponse result = GetTop10CampainListResponse.from(
            advertisementFacade.getTop10()
        );
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    /**
     * 광고주 자신이 올린 광고 목록 조회 (최신순)
     */
    @GetMapping("/advertisements")
    public ResponseEntity<CustomPageResponse<CampaignReaderResponse>> getCampaignsByAdvertisers(
        @RequestParam Long advertiserId,
        @RequestParam int page,
        @RequestParam int size
    ) {
        Pageable pageable = PageRequest.of(page, size);
        CampaignListReader campaigns = advertisementFacade.getAllCampaignsByAdvertisers(
            advertiserId, pageable);
        Page<Campaign> campaignList = campaigns.getCampaignList();
        AdvertiserInfo advertiserInfo = campaigns.getAdvertiserInfo();


        CustomPageResponse<CampaignReaderResponse> result = new CustomPageResponse<>(
            campaignList.stream().map(
                campaign -> CampaignReaderResponse.from(
                    new CampaignReader(campaign,
                        advertiserInfo,
                        campaigns.getImageMap().get(campaign.getId()),
                        campaigns.getSignMap().get(campaign.getId())
                    )
                )
            ).collect(Collectors.toList()),
            campaigns.getCampaignList().getNumber(),
            campaigns.getCampaignList().getSize(),
            campaigns.getCampaignList().getTotalPages(),
            campaigns.getCampaignList().getTotalElements()
        );
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    /**
     * 캠페인 모집 종료
     * TODO 배치로 종료된 광고 종료 설정하기
     * 전체 조회 / 탑텐에서만 안보임
     */
    @PostMapping("/{advertisementId}/end")
    public ResponseEntity<EndedCampaignResponse> endCampaign(
        @PathVariable Long advertisementId
    ) {
        EndedCampaignResponse result =
            EndedCampaignResponse.from(advertisementFacade.end(advertisementId));

        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    /**
     * 광고 검색 / 검색 조건별 전체 조회
     */
    @GetMapping("/search")
    public ResponseEntity<CustomPageResponse<CampaignReaderResponse>> searchAndReadCampaignList(
        @RequestParam(defaultValue = "0") Integer page,
        @RequestParam(defaultValue = "10") Integer size,
        @RequestParam(defaultValue = "ALL") List<AdCategory> category,
        @RequestParam(defaultValue = "INSTAGRAM") List<AdPlatform> platform,
        @RequestParam(defaultValue = "0") Integer minAge,
        @RequestParam(defaultValue = "100") Integer maxAge,
        @RequestParam(defaultValue = "0") Integer minFollower,
        @RequestParam(defaultValue = "0") Integer minPrice,
        @RequestParam(defaultValue = "1000000000") Integer maxPrice,
        @RequestParam(defaultValue = "ALL") List<Region> region,
        @RequestParam(required = false) String keyword,
        @RequestParam(defaultValue = "POPULARITY") CampaignSort sortKey
    ) {

        Page<CampaignReader> searched = advertisementFacade.search(
            PageRequest.of(page, size),
            SearchCondition.from(
                category,
                platform,
                minAge,
                maxAge,
                minFollower,
                minPrice,
                maxPrice,
                region,
                keyword,
                sortKey
            )
        );

        CustomPageResponse<CampaignReaderResponse> result = new CustomPageResponse<>(
            searched.stream().map(
                CampaignReaderResponse::from
            ).collect(Collectors.toList()),
            searched.getNumber(),
            searched.getSize(),
            searched.getTotalPages(),
            searched.getTotalElements()
        );
        return new ResponseEntity<>(
            result, HttpStatus.OK);
    }


    /**
     * <백엔드 통신용 api>
     */
    @GetMapping("/ads")
    public ResponseEntity<List<CampaignResponse>> getCampaignListById(
        @RequestParam(name = "adId") List<Long> adIdList
    ) {
        List<CampaignResponse> result =
            advertisementFacade.getCampaignListByIdList(adIdList).stream()
                .map(CampaignResponse::from).collect(Collectors.toList());
        return new ResponseEntity<>(result, HttpStatus.OK);
    }


}
