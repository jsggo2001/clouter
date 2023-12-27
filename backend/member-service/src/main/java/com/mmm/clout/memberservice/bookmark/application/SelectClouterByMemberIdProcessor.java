package com.mmm.clout.memberservice.bookmark.application;

import com.mmm.clout.memberservice.bookmark.domain.Bookmark;
import com.mmm.clout.memberservice.bookmark.domain.repository.BookmarkRepository;
import com.mmm.clout.memberservice.clouter.application.reader.ClouterReader;
import com.mmm.clout.memberservice.clouter.domain.Clouter;
import com.mmm.clout.memberservice.clouter.domain.repository.ClouterRepository;
import com.mmm.clout.memberservice.image.domain.Image;
import com.mmm.clout.memberservice.image.domain.repository.ImageRepository;
import com.mmm.clout.memberservice.image.presentation.ImageResponse;
import com.querydsl.jpa.impl.JPAQuery;
import lombok.RequiredArgsConstructor;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.support.PageableExecutionUtils;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@RequiredArgsConstructor
public class SelectClouterByMemberIdProcessor {

    private final BookmarkRepository bookmarkRepository;
    private final ClouterRepository clouterRepository;
    private final ImageRepository imageRepository;

    @Transactional
    public Page<ClouterReader> execute(Long memberId, Pageable pageable) {
        List<Long> idList = bookmarkRepository.findByMemberId(memberId, pageable).stream().map(v -> v.getTargetId()).collect(Collectors.toList());
        List<Clouter> clouterList = clouterRepository.findByIdIn(idList);

        Map<Long, List<Image>> imageMap = imageRepository.findByIdIn(idList).stream()
                .collect(Collectors.groupingBy(image -> image.getMember().getId()));
//
//        List<ClouterReader> result = clouterList.stream()
//                .map(v->new ClouterReader(v,
//                        imageMap.get(v.getId()).stream()
//                        .map(img->new ImageResponse(img))
//                        .collect(Collectors.toList())))
//                .collect(Collectors.toList());
        List<ClouterReader> result = clouterList.stream()
                .map(v -> {
                    List<ImageResponse> imageResponses = Optional.ofNullable(imageMap.get(v.getId()))
                            .map(images -> images.stream().map(ImageResponse::new).collect(Collectors.toList()))
                            .orElse(Collections.emptyList());

                    return new ClouterReader(v, imageResponses);
                })
                .collect(Collectors.toList());

        JPAQuery<Bookmark> countQuery = bookmarkRepository.findByMemberIdForCount(memberId);

        return PageableExecutionUtils.getPage(result, pageable, countQuery::fetchCount);
    }
}
