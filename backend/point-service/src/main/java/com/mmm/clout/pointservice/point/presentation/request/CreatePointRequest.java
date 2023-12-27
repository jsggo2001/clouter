package com.mmm.clout.pointservice.point.presentation.request;

import javax.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class CreatePointRequest {

    @NotNull
    private Long memberId;

}
