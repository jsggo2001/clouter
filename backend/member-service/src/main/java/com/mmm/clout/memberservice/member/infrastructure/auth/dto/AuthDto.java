package com.mmm.clout.memberservice.member.infrastructure.auth.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

public class AuthDto {

    @Getter
    @Setter
    @NoArgsConstructor(access = AccessLevel.PROTECTED)
    public static class LoginDto {
        private String userId;
        @Schema(defaultValue = "stringst")
        private String password;

        @Builder
        public LoginDto(String email, String password) {
            this.userId = email;
            this.password = password;
        }
    }

    @Data
    public static class UserIdDto {
        private String userID;
    }

    @Getter
    @Setter
    @NoArgsConstructor(access = AccessLevel.PROTECTED)
    @ToString
    public static class SignupDto {
        private String userId;
        private String password;

        @Builder
        public SignupDto(String email, String password) {
            this.userId = email;
            this.password = password;
        }

        public static SignupDto encodePassword(SignupDto signupDto, String encodedPassword) {
            SignupDto newSignupDto = new SignupDto();
            newSignupDto.userId = signupDto.getUserId();
            newSignupDto.password = encodedPassword;
            return newSignupDto;
        }
    }

    @Getter
    @NoArgsConstructor(access = AccessLevel.PROTECTED)
    public static class TokenDto {
        private String accessToken;
        private String refreshToken;

        public TokenDto(String accessToken, String refreshToken) {
            this.accessToken = accessToken;
            this.refreshToken = refreshToken;
        }
    }
}
