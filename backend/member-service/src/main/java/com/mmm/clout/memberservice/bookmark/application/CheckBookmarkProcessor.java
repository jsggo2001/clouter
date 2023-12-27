package com.mmm.clout.memberservice.bookmark.application;

import com.mmm.clout.memberservice.bookmark.domain.Bookmark;
import com.mmm.clout.memberservice.bookmark.domain.exception.NotFoundBookmarkException;
import com.mmm.clout.memberservice.bookmark.domain.repository.BookmarkRepository;
import com.mmm.clout.memberservice.member.domain.Member;
import com.mmm.clout.memberservice.member.domain.repository.MemberRepository;
import com.mmm.clout.memberservice.star.domain.exception.NotFoundMemberException;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class CheckBookmarkProcessor {

    private final BookmarkRepository bookmarkRepository;
    private final MemberRepository memberRepository;

    public boolean execute(Long memberId, Long targetId) {
        Member findMember = memberRepository.findById(memberId).orElseThrow(NotFoundMemberException::new);
        Bookmark findBookmark = bookmarkRepository.findByMemberAndTargetId(findMember, targetId).orElse(null);
        return findBookmark != null ? true : false;
    }
}
