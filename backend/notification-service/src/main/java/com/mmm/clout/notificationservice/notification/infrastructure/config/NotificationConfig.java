package com.mmm.clout.notificationservice.notification.infrastructure.config;

import com.mmm.clout.notificationservice.notification.application.CheckMemberTokenProcessor;
import com.mmm.clout.notificationservice.notification.domain.repository.MemberFcmTokenRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class NotificationConfig {

    @Bean
    public CheckMemberTokenProcessor checkMemberTokenProcessor(
        MemberFcmTokenRepository memberFcmTokenRepository
    ) {
        return new CheckMemberTokenProcessor(memberFcmTokenRepository);
    }

}
