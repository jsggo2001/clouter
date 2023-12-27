package com.mmm.clout.memberservice.member.presentation.docs;

import com.mmm.clout.memberservice.common.Role;
import com.mmm.clout.memberservice.member.infrastructure.auth.dto.AuthDto;
import com.mmm.clout.memberservice.member.presentation.request.PwdUpdateRequst;
import com.mmm.clout.memberservice.member.presentation.response.AddCountContractResponse;
import com.mmm.clout.memberservice.member.presentation.response.IdDuplicateResponse;
import com.mmm.clout.memberservice.member.presentation.response.PwdUpdateResponse;
import com.mmm.clout.memberservice.member.presentation.response.SendSmsResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Tag(name = "기본 유저 CRUD", description = "유저 로그인, 로그아웃, 리이슈 등등 인증 서비스 제공 api")
public interface MemberControllerDocs {


    @Operation(summary = "로그인",
        responses =
        @ApiResponse(responseCode = "200", description = "헤더를 사용해서 엑세스토큰과, 리프레시 토큰 리턴"
        )
    )
    public ResponseEntity<?> login(@RequestBody @Valid AuthDto.LoginDto loginDto);

    @Operation(summary = "중복체크",
        responses =
        @ApiResponse(responseCode = "200", description = "중복이 없으면 true, 중복이면 익셉션 발생(409)",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=IdDuplicateResponse.class))
        )
    )
    public ResponseEntity<IdDuplicateResponse> duplicateCheck(
        @RequestParam("userId") String userId
    );

    @Operation(summary = "액세스 토큰 재발급",
        responses =
        @ApiResponse(responseCode = "200", description = "액세스 토큰이 만료 되었을 경우 리스폰트 토큰을 보내면 엑세스 토큰 재발급"
        )
    )

    public ResponseEntity<?> reissue(
        @RequestHeader("REFRESH_TOKEN") String requestRefreshToken,
        @RequestHeader(HttpHeaders.AUTHORIZATION) String requestAccessToken);


    @Operation(summary = "로그아웃",
        responses =
        @ApiResponse(responseCode = "200", description = "리프레시 토큰 삭제"
        )
    )
    public ResponseEntity<?> logout(@RequestHeader("Authorization") String requestAccessToken);

    @Operation(summary = "인증키 sms 발송",
        responses =
        @ApiResponse(responseCode = "200", description = "인증키를 발송하고 해당하는 4자리의 인증키 string으로 반환"
        )
    )
    public ResponseEntity<String> sendSms(
        @RequestParam String phoneNumber);

    @Operation(summary = "비밀번호 변경",
        responses =
        @ApiResponse(responseCode = "200", description = "멤버의 비밀번호를 바꿔주는 api",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=PwdUpdateResponse.class))
        )
    )
    public ResponseEntity<PwdUpdateResponse> pwdUpdate(
        @RequestBody PwdUpdateRequst request);

    @Operation(summary = "비밀번호 찾기 sms발송",
        responses =
        @ApiResponse(responseCode = "200", description = "비밀번호 찾을 때 사용하는 sms 발송",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=SendSmsResponse.class))
        )
    )
    public ResponseEntity<SendSmsResponse> sendSmsByUserId(
        @RequestParam String userid,
        @RequestParam String phoneNumber
    );

    @Operation(summary = "계약 건수 플러스 api",
        responses =
        @ApiResponse(responseCode = "200", description = "계약이 성사 되었을때 계약 카운트 플러스",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=AddCountContractResponse.class))
        )
    )
    @GetMapping("/addCountOfContract")
    public ResponseEntity<AddCountContractResponse> addCount(
            @RequestParam("idList") List<Long> idList,
            @RequestParam("addType") boolean addType
    );

    @Operation(summary = "회원 가입용 번호 중복 검증 및 인증번호 sms 발송 api",
        responses =
        @ApiResponse(responseCode = "200", description = "sms 발송 api",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=String.class))
        )
    )
    @GetMapping("/sendsms/create")
    public ResponseEntity<String> sendSms(
        @RequestParam String phoneNumber,
        @RequestParam Role role
    );
}
