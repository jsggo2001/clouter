package com.mmm.clout.memberservice.bookmark.presentation.response;

import com.mmm.clout.memberservice.bookmark.domain.Bookmark;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ClouterBookmarkResponse {

    private Long bookmarkId;

    public static ClouterBookmarkResponse from(Bookmark bookmark) {
        return new ClouterBookmarkResponse(bookmark.getId());
    }
}
