package com.mmm.clout.memberservice.member.presentation;

import com.mmm.clout.memberservice.common.Role;
import com.mmm.clout.memberservice.common.entity.sms.SmsService;
import com.mmm.clout.memberservice.member.application.LoginReader;
import com.mmm.clout.memberservice.member.infrastructure.auth.dto.AuthDto;
import com.mmm.clout.memberservice.member.infrastructure.auth.service.AuthService;
import com.mmm.clout.memberservice.member.infrastructure.auth.service.MemberService;
import com.mmm.clout.memberservice.member.presentation.docs.MemberControllerDocs;
import com.mmm.clout.memberservice.member.presentation.request.PwdUpdateRequst;
import com.mmm.clout.memberservice.member.presentation.response.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.bouncycastle.cert.ocsp.Req;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Random;

@RestController
@RequestMapping("/v1/members")
@RequiredArgsConstructor
@Slf4j
public class MemberController implements MemberControllerDocs {

    private final AuthService authService;
    private final SmsService smsService;
    private final MemberService memberService;

    private final long COOKIE_EXPIRATION = 7776000; // 90일

    // 로그인 -> 토큰 발급
    @PostMapping("/login")
    public ResponseEntity<LoginReseponse> login(@RequestBody @Valid AuthDto.LoginDto loginDto) {
        LoginReader reader = authService.login(loginDto);
        AuthDto.TokenDto tokenDto = reader.getTokenDto();
        return ResponseEntity.ok()
            .header("REFRESH-TOKEN", tokenDto.getRefreshToken())
            .header(HttpHeaders.AUTHORIZATION, "Bearer " + tokenDto.getAccessToken())
            .body(reader.toResponse());
    }

    @GetMapping("/duplicate")
    public ResponseEntity<IdDuplicateResponse> duplicateCheck(
        @RequestParam("userId") String userId
    ) {
        IdDuplicateResponse response = new IdDuplicateResponse(authService.dupicateCheck(userId));
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
    // 토큰 재발급
    @PostMapping("/reissue")
    public ResponseEntity<?> reissue(
            @RequestHeader("REFRESH-TOKEN") String requestRefreshToken,
            @RequestHeader(HttpHeaders.AUTHORIZATION) String requestAccessToken
                                     ) {
        AuthDto.TokenDto reissuedTokenDto = authService.reissue(requestAccessToken, requestRefreshToken);
        log.info("refresh = {}", requestRefreshToken);
        log.info("Access = {}", requestAccessToken);
        if (reissuedTokenDto != null) { // 토큰 재발급 성공
            return ResponseEntity
                .status(HttpStatus.OK)
                .header("REFRESH-TOKEN", reissuedTokenDto.getRefreshToken())
                .header(HttpHeaders.AUTHORIZATION, "Bearer " + reissuedTokenDto.getAccessToken())
                .build();

        } else { // Refresh Token 탈취 가능성
            System.out.println("재로그인 유도");
            // Cookie 삭제 후 재로그인 유도

            return ResponseEntity
                .status(HttpStatus.UNAUTHORIZED)
                .header("REFRESH-TOKEN", "")
                .build();
        }
    }

    // 로그아웃
    @PostMapping("/logout")
    public ResponseEntity<?> logout(@RequestHeader("Authorization") String requestAccessToken) {
        authService.logout(requestAccessToken);

        return ResponseEntity
            .status(HttpStatus.OK)
            .header("REFRESH-TOKEN", "")
            .build();
    }

    @GetMapping("/sendsms")
    public ResponseEntity<String> sendSms(
        @RequestParam String phoneNumber
    ) {
        String result = smsService.smsSend(phoneNumber, makeAuthKey());
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @GetMapping("/sendsms/create")
    public ResponseEntity<String> sendSms(
        @RequestParam String phoneNumber,
        @RequestParam Role role
    ) {
        memberService.checkPhonenumber(phoneNumber, role);
        String result = smsService.smsSend(phoneNumber, makeAuthKey());
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @GetMapping("/sendsms/find")
    public ResponseEntity<SendSmsResponse> sendSmsByUserId(
        @RequestParam String userid,
        @RequestParam String phoneNumber
    ) {
        Long memberId = memberService.getUserByUserId(userid).getId();
        String key = smsService.smsSend(phoneNumber, makeAuthKey());
        SendSmsResponse result = new SendSmsResponse(memberId, key);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @PatchMapping("/pwd")
    public ResponseEntity<PwdUpdateResponse> pwdUpdate(
        @Valid @RequestBody PwdUpdateRequst request
    ) {
        PwdUpdateResponse response = PwdUpdateResponse.from(
            memberService.updateUserPassword(request)
        );
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/addCountOfContract")
    public ResponseEntity<AddCountContractResponse> addCount(
        @RequestParam("idList") List<Long> idList,
        @RequestParam("addType") boolean addType
    ) {
        AddCountContractResponse response = memberService.addCountContract(idList, addType);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    private String makeAuthKey() {
        Random random = new Random();
        int randomNumber = random.nextInt(9000) + 1000;
        String randomString = String.valueOf(randomNumber);
        return randomString;
    }
}
