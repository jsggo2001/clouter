package com.mmm.clout.memberservice.bookmark.presentation.response;

import com.mmm.clout.memberservice.bookmark.domain.Bookmark;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class AdBookmarkResponse {

    private Long bookmarkId;

    public static AdBookmarkResponse from(Bookmark bookmark) {
        return new AdBookmarkResponse(bookmark.getId());
    }
}
