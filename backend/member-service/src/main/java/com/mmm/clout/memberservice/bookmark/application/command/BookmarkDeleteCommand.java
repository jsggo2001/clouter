package com.mmm.clout.memberservice.bookmark.application.command;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class BookmarkDeleteCommand {

    private Long memberId;
    private Long targetId;
}
