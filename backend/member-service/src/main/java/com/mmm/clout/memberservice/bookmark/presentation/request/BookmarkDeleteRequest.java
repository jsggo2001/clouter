package com.mmm.clout.memberservice.bookmark.presentation.request;

import com.mmm.clout.memberservice.bookmark.application.command.BookmarkDeleteCommand;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class BookmarkDeleteRequest {

    private final Long memberId;

    private final Long targetId;

    public BookmarkDeleteCommand toCommand() {
        return new BookmarkDeleteCommand(this.memberId, this.targetId);
    }
}
