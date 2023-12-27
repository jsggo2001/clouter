package com.mmm.clout.contractservice;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

import javax.annotation.PostConstruct;
import java.util.Date;
import java.util.TimeZone;

@Slf4j
@SpringBootApplication
@EnableJpaAuditing
@EnableFeignClients
public class ContractServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(ContractServiceApplication.class, args);
	}

	@PostConstruct
	public void started() {
		TimeZone.setDefault(TimeZone.getTimeZone("Asia/Seoul"));
		log.info("현재 시각: {}", new Date());
	}
}
