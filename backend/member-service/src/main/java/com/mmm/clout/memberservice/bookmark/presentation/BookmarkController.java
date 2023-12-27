package com.mmm.clout.memberservice.bookmark.presentation;

import com.mmm.clout.memberservice.bookmark.application.facade.BookmarkFacade;
import com.mmm.clout.memberservice.bookmark.application.reader.CampaignReader;
import com.mmm.clout.memberservice.bookmark.presentation.docs.BookmarkControllerDocs;
import com.mmm.clout.memberservice.bookmark.presentation.request.BookmarkDeleteRequest;
import com.mmm.clout.memberservice.bookmark.presentation.request.CreateAdBookmarkRequest;
import com.mmm.clout.memberservice.bookmark.presentation.request.CreateClouterBookmarkRequest;
import com.mmm.clout.memberservice.bookmark.presentation.response.*;
import com.mmm.clout.memberservice.clouter.application.reader.ClouterReader;
import com.mmm.clout.memberservice.clouter.presentation.response.CustomPageResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1/bookmarks")
public class BookmarkController implements BookmarkControllerDocs {

    private final BookmarkFacade bookmarkFacade;

    @PostMapping("/ad")
    public ResponseEntity<AdBookmarkResponse> adBookmark(
        @Valid @RequestBody CreateAdBookmarkRequest request
    ) {
        AdBookmarkResponse response = AdBookmarkResponse.from(
            bookmarkFacade.createAdBookmark(request.toCommand())
        );
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PostMapping("/clouter")
    public ResponseEntity<ClouterBookmarkResponse> clouterBookmark(
        @Valid @RequestBody CreateClouterBookmarkRequest request
    ) {
        ClouterBookmarkResponse response = ClouterBookmarkResponse.from(
            bookmarkFacade.createClouterBookmark(request.toCommand())
        );
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @DeleteMapping("/delete")
    public ResponseEntity<BookmarkDeleteResponse> delete(
        @Valid @RequestBody BookmarkDeleteRequest request
    ) {
        BookmarkDeleteResponse response = BookmarkDeleteResponse.from(
            bookmarkFacade.delete(request.toCommand())
        );
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/ad")
    public ResponseEntity<CustomPageResponse<CampaignReader>> selectAdBookmarkByMemberId(
        @RequestParam(defaultValue = "0") Integer page,
        @RequestParam(defaultValue = "10") Integer size,
        @RequestParam("memberId") Long memberId
    ) {
        Page<CampaignReader> searched = bookmarkFacade.selectAdByMemberId(memberId, PageRequest.of(page, size));
        CustomPageResponse response = new CustomPageResponse(
            searched.toList(),
            searched.getNumber(),
            searched.getSize(),
            searched.getTotalPages(),
            searched.getTotalElements()
        );
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/clouter")
    public ResponseEntity<CustomPageResponse<ClouterReader>> selectClouterBookmarkByMemberId(
        @RequestParam(defaultValue = "0") Integer page,
        @RequestParam(defaultValue = "10") Integer size,
        @RequestParam("memberId") Long memberId
    ) {
        Page<ClouterReader> searched = bookmarkFacade.selectClouterByMemberId(memberId, PageRequest.of(page, size));
        CustomPageResponse response = new CustomPageResponse(
            searched.toList(),
            searched.getNumber(),
            searched.getSize(),
            searched.getTotalPages(),
            searched.getTotalElements()
        );
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/check")
    public ResponseEntity<BookmarkCheckResponse> check(
        @RequestParam("memberId") Long memberId,
        @RequestParam("targetId") Long targetId
    ) {
        BookmarkCheckResponse response = new BookmarkCheckResponse(
            bookmarkFacade.check(memberId, targetId)
        );
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
