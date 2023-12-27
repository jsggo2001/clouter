package com.mmm.clout.memberservice.bookmark.presentation.response;

import com.mmm.clout.memberservice.advertiser.domain.Advertiser;
import com.mmm.clout.memberservice.clouter.application.reader.ClouterReader;
import com.mmm.clout.memberservice.clouter.domain.Clouter;
import com.mmm.clout.memberservice.clouter.presentation.response.SelectClrResponse;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;

@Getter
public class ClouterBookmarkListResponse {

    private List<SelectClrResponse> clouterList;

    public static ClouterBookmarkListResponse from(List<ClouterReader> list) {
        return new ClouterBookmarkListResponse(list);
    }

    public ClouterBookmarkListResponse(List<ClouterReader> list) {
        this.clouterList = list.stream().map(v -> new SelectClrResponse(v)).collect(Collectors.toList());
    }
}
