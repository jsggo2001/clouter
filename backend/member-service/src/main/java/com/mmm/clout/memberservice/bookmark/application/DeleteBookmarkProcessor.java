package com.mmm.clout.memberservice.bookmark.application;

import com.mmm.clout.memberservice.bookmark.application.command.BookmarkDeleteCommand;
import com.mmm.clout.memberservice.bookmark.domain.Bookmark;
import com.mmm.clout.memberservice.bookmark.domain.exception.NotFoundBookmarkException;
import com.mmm.clout.memberservice.bookmark.domain.repository.BookmarkRepository;
import com.mmm.clout.memberservice.member.domain.Member;
import com.mmm.clout.memberservice.member.domain.repository.MemberRepository;
import com.mmm.clout.memberservice.star.domain.exception.NotFoundMemberException;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
public class DeleteBookmarkProcessor {

    private final BookmarkRepository bookmarkRepository;
    private final MemberRepository memberRepository;

    @Transactional
    public Long execute(BookmarkDeleteCommand command) {
        Member member = memberRepository.findById(command.getMemberId()).orElseThrow(NotFoundMemberException::new);
        Bookmark findBookmark = bookmarkRepository.findByMemberAndTargetId(member, command.getTargetId()).orElseThrow(() -> new NotFoundBookmarkException());
        Long bookmarkId = findBookmark.getId();
        bookmarkRepository.delete(findBookmark);
        return bookmarkId;
    }
}
