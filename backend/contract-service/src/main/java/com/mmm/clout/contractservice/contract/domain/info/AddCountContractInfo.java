package com.mmm.clout.contractservice.contract.domain.info;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@AllArgsConstructor
@Getter
public class AddCountContractInfo {

    private List<Long> memberIdList;

    private List<Integer> countOfContract;
}