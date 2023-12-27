package com.mmm.clout.memberservice.bookmark.application;

import com.mmm.clout.memberservice.bookmark.application.command.CreateAdBookmarkCommand;
import com.mmm.clout.memberservice.bookmark.application.command.CreateClouterBookmarkCommand;
import com.mmm.clout.memberservice.bookmark.domain.Bookmark;
import com.mmm.clout.memberservice.bookmark.domain.repository.BookmarkRepository;
import com.mmm.clout.memberservice.member.domain.Member;
import com.mmm.clout.memberservice.member.domain.repository.MemberRepository;
import com.mmm.clout.memberservice.star.domain.exception.NotFoundMemberException;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
public class CreateClouterBookmarkProcessor {

    private final BookmarkRepository bookmarkRepository;
    private final MemberRepository memberRepository;

    @Transactional
    public Bookmark execute(CreateClouterBookmarkCommand command) {
        Member member = memberRepository.findById(command.getMemberId()).orElseThrow(() -> new NotFoundMemberException());
        Bookmark bookmark = bookmarkRepository.save(command.toEntity(member));
        return bookmark;
    }
}
