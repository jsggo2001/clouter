package com.mmm.clout.memberservice.bookmark.presentation.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CompanyResponse  {

    @Schema(description = "회사명")
    private String companyName;

    public static CompanyResponse from(String companyName) {
        return new CompanyResponse(
            companyName
        );
    }
}

