package com.mmm.clout.contractservice.contract.presentation.response;

import com.mmm.clout.contractservice.contract.domain.Contract;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class DeleteContractResponse {

    @Schema(description = "수정된 계약 id")
    private Long contractId;

    public static DeleteContractResponse from(Long id) {
        return new DeleteContractResponse(id);
    }
}
