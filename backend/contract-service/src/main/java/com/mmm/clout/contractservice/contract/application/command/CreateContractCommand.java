package com.mmm.clout.contractservice.contract.application.command;

import com.mmm.clout.contractservice.contract.domain.AdvertiserInfo;
import com.mmm.clout.contractservice.contract.domain.ClouterInfo;
import com.mmm.clout.contractservice.contract.domain.Contract;
import com.mmm.clout.contractservice.contract.domain.info.SelectAdrInfo;
import com.mmm.clout.contractservice.contract.domain.info.SelectClrInfo;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CreateContractCommand {

    private String name;

    private Long applyId;

    private Long price;

    private String postDeadline;

    private String contractExpiration;

    private String contents;

    private Long clouterId;

    private Long advertiserId;

    private String path;

    public Contract toEntity(SelectClrInfo clouter, SelectAdrInfo advertiser) {
        return Contract.create(
              this.name,
              this.applyId,
              this.price,
              this.postDeadline,
              this.contractExpiration,
              this.contents,
              new ClouterInfo(clouter),
              new AdvertiserInfo(advertiser),
              this.path
        );
    }
}
