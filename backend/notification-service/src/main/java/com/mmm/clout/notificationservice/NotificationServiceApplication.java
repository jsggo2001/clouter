package com.mmm.clout.notificationservice;

import static org.apache.kafka.common.requests.DeleteAclsResponse.log;

import jakarta.annotation.PostConstruct;
import java.util.Date;
import java.util.TimeZone;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@EnableJpaAuditing
@SpringBootApplication
public class NotificationServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(NotificationServiceApplication.class, args);
	}

	@PostConstruct
	public void started() {
		TimeZone.setDefault(TimeZone.getTimeZone("Asia/Seoul"));
		log.info("현재 시각: {}", new Date());
	}
}
