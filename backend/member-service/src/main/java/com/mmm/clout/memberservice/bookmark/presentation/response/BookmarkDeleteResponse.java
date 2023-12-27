package com.mmm.clout.memberservice.bookmark.presentation.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class BookmarkDeleteResponse {
    private Long bookmarkId;
    public static BookmarkDeleteResponse from(Long bookmarkId) {
        return new BookmarkDeleteResponse(bookmarkId);
    }
}
