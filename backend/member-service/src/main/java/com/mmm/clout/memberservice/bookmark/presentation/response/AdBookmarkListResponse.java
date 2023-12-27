package com.mmm.clout.memberservice.bookmark.presentation.response;

import com.mmm.clout.memberservice.bookmark.application.reader.CampaignReader;
import lombok.Getter;

import java.util.List;

@Getter
public class AdBookmarkListResponse {

    List<CampaignReader> campaignList;

    public AdBookmarkListResponse(List<CampaignReader> adReaders) {
        this.campaignList = adReaders;
    }

    public static AdBookmarkListResponse from(List<CampaignReader> adReader) {
        return new AdBookmarkListResponse(adReader);
    }
}
