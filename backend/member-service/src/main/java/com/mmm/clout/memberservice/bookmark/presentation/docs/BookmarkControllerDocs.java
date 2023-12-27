package com.mmm.clout.memberservice.bookmark.presentation.docs;

import com.mmm.clout.memberservice.bookmark.application.reader.CampaignReader;
import com.mmm.clout.memberservice.bookmark.presentation.request.BookmarkDeleteRequest;
import com.mmm.clout.memberservice.bookmark.presentation.request.CreateAdBookmarkRequest;
import com.mmm.clout.memberservice.bookmark.presentation.request.CreateClouterBookmarkRequest;
import com.mmm.clout.memberservice.bookmark.presentation.response.*;
import com.mmm.clout.memberservice.clouter.application.reader.ClouterReader;
import com.mmm.clout.memberservice.clouter.presentation.response.CustomPageResponse;
import com.mmm.clout.memberservice.star.presentation.request.createStarDetailRequest;
import com.mmm.clout.memberservice.star.presentation.response.CreateStarResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

@Tag(name = "북마크 CRUD", description = "북마크를 관리하는 api")
public interface BookmarkControllerDocs {

    @Operation(summary = "광고 북마크 여부 체크 api",
        responses =
        @ApiResponse(responseCode = "200", description = "북마크 여부 boolean 리턴",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=BookmarkCheckResponse.class))
        )
    )
    public ResponseEntity<BookmarkCheckResponse> check(
        @RequestParam("memberId") Long memberId,
        @RequestParam("targetId") Long targetId
    );


    @Operation(summary = "광고 북마크 생성 api",
        responses =
        @ApiResponse(responseCode = "200", description = "생성된 북마크 id 리턴",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=AdBookmarkResponse.class))
        )
    )
    public ResponseEntity<AdBookmarkResponse> adBookmark(
        @RequestBody CreateAdBookmarkRequest request
    );

    @Operation(summary = "클라우터 북마크 생성 api",
        responses =
        @ApiResponse(responseCode = "200", description = "생성된 북마크 id 리턴",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=ClouterBookmarkResponse.class))
        )
    )
    public ResponseEntity<ClouterBookmarkResponse> clouterBookmark(
        @RequestBody CreateClouterBookmarkRequest request
    );

    @Operation(summary = "북마크 삭제 api",
        responses =
        @ApiResponse(responseCode = "200", description = "삭제된 북마크 id 리턴",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=BookmarkDeleteResponse.class))
        )
    )
    public ResponseEntity<BookmarkDeleteResponse> delete(
        @RequestBody BookmarkDeleteRequest request
    );

    @Operation(summary = "광고주가 북마크한 클라우터들 조회 api",
        responses =
        @ApiResponse(responseCode = "200", description = "클라우터 상세 데이터 리턴",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=CustomPageResponse.class))
        )
    )
    public ResponseEntity<CustomPageResponse<ClouterReader>> selectClouterBookmarkByMemberId(
        @RequestParam(defaultValue = "0") Integer page,
        @RequestParam(defaultValue = "10") Integer size,
        @RequestParam("memberId") Long memberId
    );

    @Operation(summary = "클라우터가 북마크한 광고들 조회 api",
        responses =
        @ApiResponse(responseCode = "200", description = "광고 상세 데이터 리턴",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=AdBookmarkListResponse.class))
        )
    )
    public ResponseEntity<CustomPageResponse<CampaignReader>> selectAdBookmarkByMemberId(
        @RequestParam(defaultValue = "0") Integer page,
        @RequestParam(defaultValue = "10") Integer size,
        @RequestParam("memberId") Long memberId
    );
}
