package com.mmm.clout.contractservice.contract.application.reader;

import com.mmm.clout.contractservice.common.State;
import com.mmm.clout.contractservice.contract.domain.Contract;
import com.mmm.clout.contractservice.contract.presentation.response.AdvertiserInfoResponse;
import com.mmm.clout.contractservice.contract.presentation.response.ClouterInfoResponse;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class ContractReader {

    @Schema(description = "조회된 계약 id")
    private Long contractId;

    @Schema(description = "조회된 계약 이름")
    private String name;

    @Schema(description = "조회된 계약비")
    private Long price;

    @Schema(description = "조회된 게시 기간")
    private String postDeadline;

    @Schema(description = "조회된 계약 기간")
    private String contractExpiration;

    @Schema(description = "조회된 계약 상세 내역")
    private String contents;

    private ClouterInfoReader clouterInfo;

    private AdvertiserInfoReader advertiserInfo;

    @Schema(description = "조회된 계약 상태")
    private State state;

    private String path;

    public ContractReader(Contract contract) {
        this.contractId = contract.getId();
        this.name = contract.getName();
        this.price = contract.getPrice();
        this.postDeadline = contract.getPostDeadline();
        this.contractExpiration = contract.getContractExpiration();
        this.contents = contract.getContents();
        this.clouterInfo = new ClouterInfoReader(contract.getClouterInfo());
        this.advertiserInfo = new AdvertiserInfoReader(contract.getAdvertiserInfo());
        this.state = contract.getState();
        this.path = contract.getPath();
    }

    public static ContractReader from(Contract contract) {
        return new ContractReader(
            contract.getId(),
            contract.getName(),
            contract.getPrice(),
            contract.getPostDeadline(),
            contract.getContractExpiration(),
            contract.getContents(),
            new ClouterInfoReader(contract.getClouterInfo()),
            new AdvertiserInfoReader(contract.getAdvertiserInfo()),
            contract.getState(),
                contract.getPath()
        );
    }

}
