package com.mmm.clout.contractservice.contract.infrastructure.configuration;

import com.mmm.clout.contractservice.contract.domain.provider.MemberProvider;
import com.mmm.clout.contractservice.contract.domain.repository.ContractRepository;
import com.mmm.clout.contractservice.contract.infrastructure.persistence.ContractRepositoryAdapter;
import com.mmm.clout.contractservice.contract.infrastructure.persistence.MemberServiceFeignClientAdapter;
import com.mmm.clout.contractservice.contract.infrastructure.persistence.feign.MemberServiceFeignClient;
import com.mmm.clout.contractservice.contract.infrastructure.persistence.jpa.JpaContractRepository;
import com.querydsl.jpa.impl.JPAQueryFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ContractRepositoryConfiguration {

    @Bean
    public ContractRepository contractRepository(
        JpaContractRepository jpaContractRepository,
        JPAQueryFactory queryFactory
    ) {
        return new ContractRepositoryAdapter(jpaContractRepository, queryFactory);
    }

    @Bean
    public MemberProvider memberProvider(MemberServiceFeignClient memberServiceFeignClient) {
        return new MemberServiceFeignClientAdapter(memberServiceFeignClient);
    }

}
