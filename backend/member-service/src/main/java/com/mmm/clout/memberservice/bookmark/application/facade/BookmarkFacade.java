package com.mmm.clout.memberservice.bookmark.application.facade;

import com.mmm.clout.memberservice.bookmark.application.*;
import com.mmm.clout.memberservice.bookmark.application.command.BookmarkDeleteCommand;
import com.mmm.clout.memberservice.bookmark.application.command.CreateAdBookmarkCommand;
import com.mmm.clout.memberservice.bookmark.application.command.CreateClouterBookmarkCommand;
import com.mmm.clout.memberservice.bookmark.domain.Bookmark;
import com.mmm.clout.memberservice.bookmark.application.reader.CampaignReader;
import com.mmm.clout.memberservice.bookmark.presentation.request.BookmarkDeleteRequest;
import com.mmm.clout.memberservice.clouter.application.reader.ClouterReader;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Getter
@AllArgsConstructor
@Service
public class BookmarkFacade {

    private final CreateAdBookmarkProcessor createAdBookmarkProcessor;
    private final CreateClouterBookmarkProcessor createClouterBookmarkProcessor;
    private final DeleteBookmarkProcessor deleteBookmarkProcessor;
    private final SelectAdByMemberIdProcessor selectAdByMemberIdProcessor;
    private final SelectClouterByMemberIdProcessor selectClouterByMemberIdProcessor;
    private final CheckBookmarkProcessor checkBookmarkProcessor;

    public Bookmark createAdBookmark(CreateAdBookmarkCommand command) {
        return createAdBookmarkProcessor.execute(command);
    }

    public Bookmark createClouterBookmark(CreateClouterBookmarkCommand command) {
        return createClouterBookmarkProcessor.execute(command);
    }

    public Long delete(BookmarkDeleteCommand command) {
        return deleteBookmarkProcessor.execute(command);
    }

    public Page<CampaignReader> selectAdByMemberId(Long memberId, Pageable pageable) {
        return selectAdByMemberIdProcessor.execute(memberId, pageable);
    }

    public Page<ClouterReader> selectClouterByMemberId(Long memberId, Pageable pageable) {
        return selectClouterByMemberIdProcessor.execute(memberId, pageable);
    }

    public boolean check(Long memberId, Long targetId) {
        return checkBookmarkProcessor.execute(memberId, targetId);
    }
}
