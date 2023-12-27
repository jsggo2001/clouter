package com.mmm.clout.advertisementservice.common.docs;

import com.mmm.clout.advertisementservice.advertisements.domain.AdCategory;
import com.mmm.clout.advertisementservice.advertisements.domain.AdPlatform;
import com.mmm.clout.advertisementservice.advertisements.domain.Region;
import com.mmm.clout.advertisementservice.advertisements.domain.search.CampaignSort;
import com.mmm.clout.advertisementservice.advertisements.persentation.request.CreateCampaignRequest;
import com.mmm.clout.advertisementservice.advertisements.persentation.request.UpdateCampaignRequest;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.CampaignReaderResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.CreateCampaignResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.CustomPageResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.DeleteCampaignResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.EndedCampaignResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.GetCampaignAndAdvertiserResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.GetCampainListByAdvertiserResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.GetTop10CampainListResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.UpdateCampaignResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;

import java.io.IOException;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;


@Tag(name = "광고 api", description = "광고 관련 api")
public interface AdvertisementControllerDocs {

    @Operation(summary = "광고 캠페인 등록",
        description = "등록자(광고주)id와 캠페인에 필요한 필드를 받아 캠페인 등록합니다.",
        parameters = {
            @Parameter(
                in = ParameterIn.HEADER,
                name = "Authorization",
                required = true,
                schema = @Schema(type = "string"),
                description = "인증 토큰"
            )
        },
        responses =
        @ApiResponse(responseCode = "201", description = "광고 캠페인 등록 성공",
            content =
            @Content(mediaType = "application/json",
                schema = @Schema(implementation = CreateCampaignResponse.class))
        ),
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            content = @Content(mediaType = "application/json",
                schema = @Schema(implementation = CreateCampaignRequest.class)),
            description = "캠페인 생성을 위한 정보",
            required = true
        )
    )
    ResponseEntity<CreateCampaignResponse> createCampaign(
        @RequestPart CreateCampaignRequest request,
        @RequestPart(value = "files", required = true) List<MultipartFile> fileList
//        @RequestPart(value = "sign", required = true) MultipartFile sign
    ) throws Exception;


    @Operation(summary = "광고 캠페인 수정",
        description = "광고 캠페인 id를 받아 정보를 수정합니다.",
        parameters = {
            @Parameter(
                in = ParameterIn.HEADER,
                name = "Authorization",
                required = true,
                schema = @Schema(type = "string"),
                description = "인증 토큰"
            ),
            @Parameter(
                in = ParameterIn.PATH,
                name = "advertisementId",
                required = true,
                description = "광고 캠페인의 고유 식별자"
            )
        },
        responses =
        @ApiResponse(responseCode = "200", description = "광고 캠페인 수정 성공",
            content =
            @Content(mediaType = "application/json",
                schema = @Schema(implementation = UpdateCampaignResponse.class))
        ),
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            content = @Content(mediaType = "application/json",
                schema = @Schema(implementation = UpdateCampaignRequest.class)),
            description = "캠페인 수정을 위한 정보",
            required = true
        )
    )
    ResponseEntity<UpdateCampaignResponse> updateCampaign(
        @PathVariable Long advertisementId,
        @RequestPart UpdateCampaignRequest request,
        @RequestPart(value = "files", required = true) List<MultipartFile> fileList
    ) throws Exception;


    @Operation(summary = "광고 캠페인 삭제 (soft 삭제)",
        description = "광고 캠페인 id를 받아 삭제합니다. (soft delete)",
        parameters = {
            @Parameter(
                in = ParameterIn.HEADER,
                name = "Authorization",
                required = true,
                schema = @Schema(type = "string"),
                description = "인증 토큰"
            ),
            @Parameter(
                in = ParameterIn.PATH,
                name = "advertisementId",
                required = true,
                description = "광고 캠페인의 고유 식별자"
            )
        },
        responses =
        @ApiResponse(responseCode = "200", description = "광고 캠페인 삭제 처리 성공",
            content =
            @Content(mediaType = "application/json",
                schema = @Schema(implementation = DeleteCampaignResponse.class))
        )
    )
    ResponseEntity<DeleteCampaignResponse> deleteCampaign(
        @PathVariable Long advertisementId
    );

    @Operation(summary = "캠페인 캠페인 상세 조회 (광고주 정보 포함)",
        description = "광고 캠페인 id를 받아 상세 정보를 조회합니다. ",
        parameters = {
            @Parameter(
                in = ParameterIn.PATH,
                name = "advertisementId",
                required = true,
                description = "광고 캠페인의 고유 식별자"
            )
        },
        responses =
        @ApiResponse(responseCode = "200", description = "광고 캠페인 상세 정보 조회 성공",
            content =
            @Content(mediaType = "application/json",
                schema = @Schema(implementation = GetCampaignAndAdvertiserResponse.class))
        )
    )
    ResponseEntity<GetCampaignAndAdvertiserResponse> getCampaignDetails(
        @PathVariable Long advertisementId
    );

    @Operation(summary = "인기 있는 광고 리스트 (10개) 조회",
        description = "모집기간 내의 캠페인 중 신청자 수 많은 순 / 우선순위가 같을경우, 최신순",
        responses =
        @ApiResponse(responseCode = "200", description = "인기 있는 광고 리스트 (10개) 조회 성공",
            content =
            @Content(mediaType = "application/json",
                schema = @Schema(implementation = GetTop10CampainListResponse.class))
        )
    )
    ResponseEntity<GetTop10CampainListResponse> getTop10Campaigns();


    @Operation(summary = "광고주 자신이 올린 광고 목록 조회 (최신순)",
        description = "광고주가 본인이 등록한 광고 캠페인 목록을 조회합니다.",
        parameters = {
            @Parameter(
                in = ParameterIn.HEADER,
                name = "Authorization",
                required = true,
                schema = @Schema(type = "string"),
                description = "인증 토큰"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "advertiserId",
                required = true,
                description = "광고주의 고유 식별자"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "page",
                required = true,
                description = "페이지 번호 (0부터 시작)"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "size",
                required = true,
                description = "한 페이지당 보여줄 글 갯수"
            )
        },
        responses =
        @ApiResponse(responseCode = "200", description = "광고주가 올린 광고 목록 조회 성공",
            content =
            @Content(mediaType = "application/json",
                schema = @Schema(implementation = CustomPageResponse.class))
        )
    )
    ResponseEntity<CustomPageResponse<CampaignReaderResponse>> getCampaignsByAdvertisers(
        @RequestParam Long advertiserId,
        @RequestParam int page,
        @RequestParam int size
    );

    @Operation(summary = "캠페인 모집 종료",
        description = "광고주가 캠페인 모집을 종료합니다.",
        parameters = {
            @Parameter(
                in = ParameterIn.HEADER,
                name = "Authorization",
                required = true,
                schema = @Schema(type = "string"),
                description = "인증 토큰"
            ),
            @Parameter(
                in = ParameterIn.PATH,
                name = "advertisementId",
                required = true,
                description = "광고 캠페인의 고유 식별자"
            )
        },
        responses =
        @ApiResponse(responseCode = "200", description = "광고 캠페인 모집 종료 처리 성공",
            content =
            @Content(mediaType = "application/json",
                schema = @Schema(implementation = EndedCampaignResponse.class))
        )
    )
    ResponseEntity<EndedCampaignResponse> endCampaign(
        @PathVariable Long advertisementId
    );


    @Operation(summary = "캠페인 검색/전체조회",
        description = "검색 필터링/카테고리/정렬 조건 등 조건에 따라 알맞은 캠페인 검색 결과를 제공합니다.",
        parameters = {
            @Parameter(
                in = ParameterIn.HEADER,
                name = "Authorization",
                required = true,
                schema = @Schema(type = "string"),
                description = "인증 토큰"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "page",
                required = true,
                description = "현재 페이지"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "size",
                required = true,
                description = "한 페이지당 보여줄 데이터 갯수(size)"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "category",
                required = true,
                description = "카테고리 리스트"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "platform",
                required = true,
                description = "플랫폼 리스트"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "minAge",
                required = true,
                description = "클라우터 최소 나이"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "maxAge",
                required = true,
                description = "클라우터 최대 나이"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "minFollower",
                required = true,
                description = "최소 팔로워 수"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "minPrice",
                required = true,
                description = "최소 광고비"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "maxPrice",
                required = true,
                description = "최대 광고비"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "region",
                required = true,
                description = "지역 리스트"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "keyword",
                required = false,
                description = "검색 키워드"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "sortKey",
                required = true,
                description = "정렬 조건"
            )
        },
        responses =
        @ApiResponse(responseCode = "200", description = "광고 캠페인 검색/전체조회",
            content =
            @Content(mediaType = "application/json",
                schema = @Schema(implementation = CustomPageResponse.class))
        )
    )
    ResponseEntity<CustomPageResponse<CampaignReaderResponse>> searchAndReadCampaignList(
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
    );

}