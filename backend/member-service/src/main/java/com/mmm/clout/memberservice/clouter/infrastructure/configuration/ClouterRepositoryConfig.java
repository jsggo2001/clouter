package com.mmm.clout.memberservice.clouter.infrastructure.configuration;

import com.mmm.clout.memberservice.clouter.domain.repository.ClouterRepository;
import com.mmm.clout.memberservice.clouter.infrastructure.persistence.ClouterRepositoryAdapter;
import com.mmm.clout.memberservice.clouter.infrastructure.persistence.jpa.JpaClouterRepository;
import com.querydsl.jpa.impl.JPAQueryFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Configuration
public class ClouterRepositoryConfig {

    @PersistenceContext
    private EntityManager em;

    @Bean
    public ClouterRepository clouterRepository(JpaClouterRepository jpaClouterRepository) {
        return new ClouterRepositoryAdapter(jpaClouterRepository, jpaQueryFactory());
    }

    @Bean
    public JPAQueryFactory jpaQueryFactory() {
        return new JPAQueryFactory(em);
    }
}
