package com.mmm.clout.advertisementservice.common.docs;

import com.mmm.clout.advertisementservice.advertisements.persentation.request.CreateCampaignRequest;
import com.mmm.clout.advertisementservice.advertisements.persentation.request.UpdateCampaignRequest;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.CreateCampaignResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.CustomPageResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.DeleteCampaignResponse;
import com.mmm.clout.advertisementservice.advertisements.persentation.response.UpdateCampaignResponse;
import com.mmm.clout.advertisementservice.apply.domain.Apply.ApplyStatus;
import com.mmm.clout.advertisementservice.apply.presentation.request.CreateApplyRequest;
import com.mmm.clout.advertisementservice.apply.presentation.response.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;


@Tag(name = "캠페인 모집 신청 api", description = "캠페인 모집 신청 관련 api")
public interface ApplyControllerDocs {


    @Operation(summary = "신청",
        description = "클라우터가 캠페인을 신청합니다.",
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
        @ApiResponse(responseCode = "201", description = "광고 모집 신청 성공",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation= CreateApplyResponse.class))
        ),
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            content = @Content(mediaType = "application/json",
                schema = @Schema(implementation = CreateApplyRequest.class)),
            description = "캠페인 신청을 위한 정보",
            required = true
        )
    )
    ResponseEntity<CreateApplyResponse> createApply(
        @RequestBody CreateApplyRequest request
    );

    @Operation(summary = "신청 취소",
        description = "클라우터가 신청한 캠페인을 신청 취소 합니다.",
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
                name = "applyId",
                required = true,
                description = "신청(apply) 고유 식별자"
            )
        }
    )
    ResponseEntity<String> cancelApply(
        @PathVariable Long applyId
    );


    @Operation(summary = "클라우터가 신청한 캠페인 목록 (종류 존재)",
        description = "클라우터가 신청한 캠페인 목록 조회합니다.",
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
                name = "clouterId",
                required = true,
                description = "신청(apply) 고유 식별자"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "type",
                required = true,
                description = "신청 상태"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "page",
                required = true,
                description = "페이지"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "size",
                required = true,
                description = "페이지당 보여줄 데이터 사이즈"
            )
        }
    )
    ResponseEntity<CustomPageResponse<GetApplyByStatusResponse>> getApplyListByStatus(
        @RequestParam Long clouterId,
        @RequestParam ApplyStatus type,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int size
    );


    @Operation(summary = "광고주가) 해당 광고 신청자 목록 조회",
        description = "광고주가) 해당 광고 신청자 목록을 조회합니다.",
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
                name = "advertisementId",
                required = true,
                description = "광고 캠페인 고유 식별자(id)"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "page",
                required = true,
                description = "페이지"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "size",
                required = true,
                description = "페이지당 보여줄 데이터 사이즈"
            )
        }
    )
    ResponseEntity<CustomPageResponse<ApplicantResponse>> getApplicantList(
        @RequestParam Long advertisementId,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int size
    );

    @Operation(summary = "신청자 한마디 조회",
        description = "신청 id에 해당하는 신청자의 한마디 메시지를 조회합니다.",
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
                name = "applyId",
                required = true,
                description = "신청 고유 식별자(id)"
            )
        }
    )
    ResponseEntity<ApplyMessageResponse> getApplyMsg(
        @PathVariable Long applyId
    );

    @Operation(summary = "클라우터가 광고를 지원 했는지 여부",
        description = "신청 id에 해당하는 신청자의 한마디 메시지를 조회합니다.",
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
                name = "advertisementId",
                required = true,
                description = "광고 id"
            ),
            @Parameter(
                in = ParameterIn.QUERY,
                name = "clouterId",
                required = true,
                description = "클라우터 id"
            )
        }
    )
    @GetMapping("/applyCheck")
    public ResponseEntity<ApplyCheckResponse> applycheck(
        @RequestParam("advertisementId") Long advertisementId,
        @RequestParam("clouterId") Long clouterId
    );
}