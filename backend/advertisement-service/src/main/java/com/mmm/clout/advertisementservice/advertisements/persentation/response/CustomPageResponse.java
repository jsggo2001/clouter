package com.mmm.clout.advertisementservice.advertisements.persentation.response;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CustomPageResponse<T> {

    @Schema(description = "데이터")
    private List<T> content;

    @Schema(description = "현재 페이지")
    private int pageNumber;

    @Schema(description = "페이지당 데이터 갯수")
    private int pageSize;

    @Schema(description = "전체 페이지 수")
    private int totalPages;

    @Schema(description = "전체 데이터 수")
    private long totalElements;
}