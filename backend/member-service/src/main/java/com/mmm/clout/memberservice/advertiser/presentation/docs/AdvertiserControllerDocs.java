package com.mmm.clout.memberservice.advertiser.presentation.docs;

import com.mmm.clout.memberservice.advertiser.presentation.request.CreateAdrRequest;
import com.mmm.clout.memberservice.advertiser.presentation.request.UpdateAdrRequest;
import com.mmm.clout.memberservice.advertiser.presentation.response.CreateAdrResponse;
import com.mmm.clout.memberservice.advertiser.presentation.response.SelectAdrResponse;
import com.mmm.clout.memberservice.advertiser.presentation.response.UpdateAdrResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import javax.validation.Valid;

@Tag(name = "광고주 CRUD", description = "광고주 회원가입, 수정, 조회를 제공하는 api")
public interface AdvertiserControllerDocs {


    @Operation(summary = "광고주 회원가입",
        responses =
        @ApiResponse(responseCode = "201", description = "생성된 광고주 id 리턴",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=CreateAdrResponse.class))
        )
    )
    public ResponseEntity<CreateAdrResponse> create(
        @RequestBody @Valid CreateAdrRequest createAdrRequest
    );

    @Operation(summary = "광고주 수정",
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
        @ApiResponse(responseCode = "200", description = "수정된 광고주 id 리스폰스",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=UpdateAdrResponse.class))
        )
    )
    public ResponseEntity<UpdateAdrResponse> update(
        @PathVariable("advertiserId") Long advertiserId,
        @RequestBody @Valid UpdateAdrRequest updateAdrRequest
    );


    @Operation(summary = "광고주 단건 조회",
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
        @ApiResponse(responseCode = "200", description = "광고주 상세 정보 리스폰스",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=SelectAdrResponse.class))
        )
    )
    public ResponseEntity<SelectAdrResponse> selectAdvertiser(
        @PathVariable("advertiserId") Long advertiserId
    );
}
