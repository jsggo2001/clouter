package com.mmm.clout.memberservice.clouter.presentation.docs;

import com.mmm.clout.memberservice.clouter.application.reader.ClouterReader;
import com.mmm.clout.memberservice.clouter.domain.search.ClouterSort;
import com.mmm.clout.memberservice.clouter.presentation.request.CreateClrRequest;
import com.mmm.clout.memberservice.clouter.presentation.request.UpdateClrRequest;
import com.mmm.clout.memberservice.clouter.presentation.response.*;
import com.mmm.clout.memberservice.common.Category;
import com.mmm.clout.memberservice.common.Platform;
import com.mmm.clout.memberservice.common.Region;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.util.List;

@Tag(name = "클라우터 CRUD", description = "클라우터 회원가입, 수정, 조회를 제공하는 api")
public interface ClouterControllerDocs {


    @Operation(summary = "클라우터 회원가입",
        responses =
        @ApiResponse(responseCode = "201", description = "생성된 클라우터 id 리턴",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=CreateClrResponse.class))
        )
    )
    @PostMapping(consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    public ResponseEntity<CreateClrResponse> create(
            @RequestPart CreateClrRequest createClrRequest,
            @RequestPart List<MultipartFile> files
    )throws Exception;

    @Operation(summary = "클라우터 수정",
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
        @ApiResponse(responseCode = "200", description = "수정된 클라우터 id 리턴",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=UpdateClrResponse.class))
        )
    )
    public ResponseEntity<UpdateClrResponse> update(
        @PathVariable("clouterId") Long clouterId,
        @Valid @RequestPart UpdateClrRequest updateClrRequest,
        @RequestPart(value = "files") List<MultipartFile> fileList
    ) throws IOException;


    @Operation(summary = "클라우터 단건 조회",
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
        @ApiResponse(responseCode = "200", description = "클라우터 상세 정보 리스폰스",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=SelectClrResponse.class))
        )
    )
    public ResponseEntity<SelectClrResponse> selectClouter(
        @PathVariable("clouterId") Long clouterId
    );

    @Operation(summary = "클라우터 top10 조회",
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
        @ApiResponse(responseCode = "200", description = "클라우터 top10 리스트 리턴",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=SelectTop10Response.class))
        )
    )
    public ResponseEntity<SelectTop10Response> getClouterTop10();


    @Operation(summary = "클라우터 검색/전체조회",
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
    public ResponseEntity<CustomPageResponse<ClouterReader>> searchAndReadCampaignList(
        @RequestParam(defaultValue = "0") Integer page,
        @RequestParam(defaultValue = "10") Integer size,
        @RequestParam(defaultValue = "ALL") List<Category> category,
        @RequestParam(defaultValue = "INSTAGRAM") List<Platform> platform,
        @RequestParam(defaultValue = "0") Integer minAge,
        @RequestParam(defaultValue = "100") Integer maxAge,
        @RequestParam(defaultValue = "0") Integer minFollower,
        @RequestParam(defaultValue = "0") Integer minPrice,
        @RequestParam(defaultValue = "1000000000") Integer maxPrice,
        @RequestParam(defaultValue = "ALL") List<Region> region,
        @RequestParam(required = false) String keyword,
        @RequestParam(defaultValue = "SCORE") ClouterSort sortKey
    );

    @Operation(summary = "클라우터 둘러보기용 상세 조회",
        responses =
        @ApiResponse(responseCode = "200", description = "둘러보기용 클라우터 상세 정보 리턴",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=SelectClrResponse.class))
        )
    )
    public ResponseEntity<SelectClrResponse> selectClouterForNoneAuth(
        @PathVariable("clouterId") Long clouterId
    );
}
