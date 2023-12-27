package com.mmm.clout.contractservice.contract.presentation.docs;

import com.mmm.clout.contractservice.contract.application.reader.ContractReader;
import com.mmm.clout.contractservice.contract.presentation.request.CreateContractRequest;
import com.mmm.clout.contractservice.contract.presentation.request.UpdateRRNContractRequest;
import com.mmm.clout.contractservice.contract.presentation.response.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.List;

@Tag(name = "계약 CRUD", description = "계약 회원가입, 수정, 조회를 제공하는 api")
public interface ContractControllerDocs {


    @Operation(summary = "계약 생성, 광고주가 클라우터를 선택함",
            responses =
            @ApiResponse(responseCode = "201", description = "생성된 계약 id 리턴",
                    content =
                    @Content(mediaType="application/json",
                            schema=@Schema(implementation=CreateContractResponse.class))
            )
    )
    public ResponseEntity<CreateContractResponse> create(
            @RequestBody @Valid CreateContractRequest createAdrRequest
    );

    @Operation(summary = "계약 클라우터 주민번호 업데이트",
            responses =
            @ApiResponse(responseCode = "200", description = "수정된 계약 id 리턴",
                    content =
                    @Content(mediaType="application/json",
                            schema=@Schema(implementation=UpdateRRNContractResponse.class))
            )
    )
    public ResponseEntity<UpdateRRNContractResponse> updateRNN(
            @PathVariable("contractId") Long id,
            @RequestBody UpdateRRNContractRequest request
    );

    @Operation(summary = "계약 상태 확정, 클라우터가 싸인하고 확정 지음",
            responses =
            @ApiResponse(responseCode = "200", description = "확정된 계약 id 리턴",
                    content =
                    @Content(mediaType="application/json",
                            schema=@Schema(implementation= UpdateStateContractResponse.class))
            )
    )
    public ResponseEntity<UpdateStateContractResponse> updateState(
            @PathVariable("contractId") Long id,
            @RequestPart(value = "files", required = false) MultipartFile file
    ) throws Exception;

    @Operation(summary = "계약 취소/삭제, 광고주가 계약 클라우터 선택 취소",
            responses =
            @ApiResponse(responseCode = "200", description = "삭제된 계약 id 리턴",
                    content =
                    @Content(mediaType="application/json",
                            schema=@Schema(implementation=DeleteContractResponse.class))
            )
    )
    public ResponseEntity<DeleteContractResponse> delete(
            @PathVariable("contractId") Long id
    );

    @Operation(summary = "계약 조회",
            responses =
            @ApiResponse(responseCode = "200", description = "조회된 계약 리턴",
                    content =
                    @Content(mediaType="application/json",
                            schema=@Schema(implementation= ContractReader.class))
            )
    )
    public ResponseEntity<ContractReader> select(
            @PathVariable("contractId") Long id
    );

    @Operation(summary = "클라우터 계약 전체 조회",
            responses =
            @ApiResponse(responseCode = "200", description = "조회된 클라우터 계약들 리턴",
                    content =
                    @Content(mediaType="application/json",
                            schema=@Schema(implementation=CustomPageResponse.class))
            )
    )
    public ResponseEntity<CustomPageResponse<ContractReader>> selectClouter(
        @RequestParam(defaultValue = "0") Integer page,
        @RequestParam(defaultValue = "10") Integer size,
        @RequestParam("clouterId") Long clouterId
    );

    @Operation(summary = "광고주 계약 전체 조회",
            responses =
            @ApiResponse(responseCode = "200", description = "조회된 광고주 계약들 리턴",
                    content =
                    @Content(mediaType="application/json",
                            schema=@Schema(implementation=CustomPageResponse.class))
            )
    )
    @GetMapping("/advertiser")
    public ResponseEntity<CustomPageResponse<ContractReader>> selectAdvertiser(
        @RequestParam(defaultValue = "0") Integer page,
        @RequestParam(defaultValue = "10") Integer size,
        @RequestParam("advertiserId") Long advertiserId
    );
}

