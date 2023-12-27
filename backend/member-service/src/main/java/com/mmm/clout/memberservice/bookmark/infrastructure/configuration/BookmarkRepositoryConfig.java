package com.mmm.clout.memberservice.bookmark.infrastructure.configuration;

import com.mmm.clout.memberservice.bookmark.domain.repository.BookmarkRepository;
import com.mmm.clout.memberservice.bookmark.infrastructure.persistence.BookmarkAdaptor;
import com.mmm.clout.memberservice.bookmark.infrastructure.persistence.jpa.JpaBookmarkRepository;
import com.querydsl.jpa.impl.JPAQueryFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class BookmarkRepositoryConfig {
    @Bean
    public BookmarkRepository bookmarkRepository(
        JpaBookmarkRepository jpaBookmarkRepository,
        JPAQueryFactory queryFactory
    ) {
        return new BookmarkAdaptor(jpaBookmarkRepository, queryFactory);
    }
}
