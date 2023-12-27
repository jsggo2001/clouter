package com.mmm.clout.advertisementservice.apply.infrastructure.config;

import com.mmm.clout.advertisementservice.apply.domain.repository.ApplyRepository;
import com.mmm.clout.advertisementservice.apply.infrastructure.persistence.ApplyRepositoryAdapter;
import com.mmm.clout.advertisementservice.apply.infrastructure.persistence.jpa.JpaApplyRepository;
import com.querydsl.jpa.impl.JPAQueryFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ApplyRepositoryConfig {


    @Bean
    ApplyRepository applyRepository(JpaApplyRepository jpaApplyRepository, JPAQueryFactory queryFactory) {
        return new ApplyRepositoryAdapter(jpaApplyRepository, queryFactory);
    }
}
