package com.mmm.clout.memberservice.bookmark.infrastructure.persistence;

import com.mmm.clout.memberservice.bookmark.domain.Bookmark;
import com.mmm.clout.memberservice.bookmark.domain.repository.BookmarkRepository;
import com.mmm.clout.memberservice.bookmark.infrastructure.persistence.jpa.JpaBookmarkRepository;
import com.mmm.clout.memberservice.member.domain.Member;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

import static com.mmm.clout.memberservice.bookmark.domain.QBookmark.bookmark;

@Repository
@RequiredArgsConstructor
public class BookmarkAdaptor implements BookmarkRepository {

    private final JpaBookmarkRepository jpaBookmarkRepository;
    private final JPAQueryFactory queryFactory;

    @Override
    public Bookmark save(Bookmark bookmark) {
        return jpaBookmarkRepository.save(bookmark);
    }

    @Override
    public Optional<Bookmark> findById(Long bookmarkId) {
        return jpaBookmarkRepository.findById(bookmarkId);
    }

    @Override
    public Optional<Bookmark> findByMemberAndTargetId(Member member, Long targetId) {
        return jpaBookmarkRepository.findByMemberAndTargetId(member, targetId);
    }

    @Override
    public void delete(Bookmark bookmark) {
        jpaBookmarkRepository.delete(bookmark);
    }

    @Override
    public List<Bookmark> findByMemberId(Long memberId, Pageable pageable) {
        return jpaBookmarkRepository.findByMemberId(memberId, pageable);
    }

    @Override
    public JPAQuery<Bookmark> findByMemberIdForCount(Long memberId) {
        JPAQuery<Bookmark> countQuery = queryFactory.query()
            .select(bookmark)
            .from(bookmark)
            .where(bookmark.member.id.eq(memberId));
        return countQuery;
    }
}
