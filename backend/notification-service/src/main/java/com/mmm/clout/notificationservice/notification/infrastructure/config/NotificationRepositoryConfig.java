package com.mmm.clout.notificationservice.notification.infrastructure.config;

import com.mmm.clout.notificationservice.notification.domain.repository.MemberFcmTokenRepository;
import com.mmm.clout.notificationservice.notification.infrastructure.persistence.NotificationRepositoryAdapter;
import com.mmm.clout.notificationservice.notification.infrastructure.persistence.jpa.JpaMemberFcmTokenRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class NotificationRepositoryConfig {

    @Bean
    public MemberFcmTokenRepository memberFcmTokenRepository(JpaMemberFcmTokenRepository jpaMemberFcmTokenRepository) {
        return new NotificationRepositoryAdapter(jpaMemberFcmTokenRepository);
    }

}
