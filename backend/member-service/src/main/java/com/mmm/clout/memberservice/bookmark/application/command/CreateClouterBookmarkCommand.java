package com.mmm.clout.memberservice.bookmark.application.command;

import com.mmm.clout.memberservice.bookmark.domain.Bookmark;
import com.mmm.clout.memberservice.bookmark.domain.BookmarkType;
import com.mmm.clout.memberservice.member.domain.Member;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CreateClouterBookmarkCommand {

    private Long memberId;

    private Long targetId;

    public Bookmark toEntity(Member member) {
        return new Bookmark(
            member,
            this.targetId,
            BookmarkType.CLOUTER
        );
    }
}
