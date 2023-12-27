package com.mmm.clout.memberservice.bookmark.domain.repository;

import com.mmm.clout.memberservice.bookmark.domain.Bookmark;
import com.mmm.clout.memberservice.clouter.domain.Clouter;
import com.mmm.clout.memberservice.member.domain.Member;
import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface BookmarkRepository {

    Bookmark save(Bookmark bookmark);

    Optional<Bookmark> findById(Long bookmarkId);

    Optional<Bookmark> findByMemberAndTargetId(Member memberId, Long targetId);

    void delete(Bookmark findBookmark);

    List<Bookmark> findByMemberId(Long memberId, Pageable pageable);

    JPAQuery<Bookmark> findByMemberIdForCount(Long memberId);
}
