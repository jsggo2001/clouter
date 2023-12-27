package com.mmm.clout.memberservice.bookmark.presentation.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class BookmarkCheckResponse {

    @Schema(description = "북마크를 했으면 true, 안했으면 false")
    private boolean check;

}
