package com.mmm.clout.memberservice.member.presentation.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
public class AddCountContractResponse {

    private List<Long> memberIdList = new ArrayList<>();

    private List<Integer> countOfContracts = new ArrayList<>();
}
