package com.mmm.clout.advertisementservice.apply.presentation.response;

import com.mmm.clout.advertisementservice.apply.application.reader.ApplyCheckReader;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class ApplyCheckResponse {

    @Schema(description = "신청에 해당하는 applyiId 신청을 했으면 아이디 값을 보내고 없으면 null값을 보냄")
    private Long applyId;

    @Schema(description = "신청을 했으면 true, 신청을 하지 않았으면 false 반환")
    private boolean applyCheck;

    public static ApplyCheckResponse from(ApplyCheckReader reader) {
        return new ApplyCheckResponse(reader.getApplyId(), reader.isApplyCheck());
    }
}
