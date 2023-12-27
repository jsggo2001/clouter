package com.mmm.clout.memberservice.member.infrastructure.configuration;

import com.mmm.clout.memberservice.member.infrastructure.auth.security.JwtAccessDeniedHandler;
import com.mmm.clout.memberservice.member.infrastructure.auth.security.JwtAuthenticationEntryPoint;
import com.mmm.clout.memberservice.member.infrastructure.auth.security.JwtAuthenticationFilter;
import com.mmm.clout.memberservice.member.infrastructure.auth.security.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity // Spring Security 설정 클래스
@EnableGlobalMethodSecurity(securedEnabled = true)
@RequiredArgsConstructor
public class SecurityConfig {

    private final JwtTokenProvider jwtTokenProvider;
    private final JwtAccessDeniedHandler jwtAccessDeniedHandler;
    private final JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;

    @Bean
    public BCryptPasswordEncoder encoder() {
        // 비밀번호를 DB에 저장하기 전 사용할 암호화
        return new BCryptPasswordEncoder();
    }

    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        // ACL(Access Control List, 접근 제어 목록)의 예외 URL 설정
        return (web)
                -> web
                .ignoring()
                .requestMatchers(PathRequest.toStaticResources().atCommonLocations()); // 정적 리소스들
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        // 인터셉터로 요청을 안전하게 보호하는 방법 설정
        http
                // jwt 토큰 사용을 위한 설정
                .csrf().disable()
                .httpBasic().disable()
                .formLogin().disable()
                .addFilterBefore(new JwtAuthenticationFilter(jwtTokenProvider), UsernamePasswordAuthenticationFilter.class)
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)



                // 예외 처리
                .and()
                .exceptionHandling()
                .authenticationEntryPoint(jwtAuthenticationEntryPoint) //customEntryPoint
                .accessDeniedHandler(jwtAccessDeniedHandler) // cutomAccessDeniedHandler
                .and()
                .authorizeRequests() // '인증'이 필요한 매핑 정보 입력
                .antMatchers("/v1/members/**").permitAll()
                .antMatchers("/**").permitAll()
                .anyRequest().authenticated()
                .and()
                .headers()
                .frameOptions().sameOrigin()
                .xssProtection()
                .and()
                .contentSecurityPolicy("script-src 'self'");

        return http.build();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

}
