package com.mmm.clout.advertisementservice.apply.presentation.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ApplyMessageResponse {

    @Schema(description = "신청 고유 식별자(id)")
    private Long applyId;

    @Schema(description = "신청자 각오 한마디")
    private String message;

}
