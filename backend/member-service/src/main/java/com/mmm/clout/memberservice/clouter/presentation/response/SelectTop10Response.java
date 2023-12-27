package com.mmm.clout.memberservice.clouter.presentation.response;

import com.mmm.clout.memberservice.clouter.application.reader.ClouterReader;
import com.mmm.clout.memberservice.common.entity.address.response.AddressResponse;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;

@AllArgsConstructor
@Getter
public class SelectTop10Response {

    private List<SelectClrResponse> clouters;


    public static SelectTop10Response from(List<ClouterReader> clouters) {
        return new SelectTop10Response(clouters.stream().map(
            clouterReader -> new SelectClrResponse(
                clouterReader.getClouterId(),
                clouterReader.getUserId(),
                clouterReader.getAvgScore(),
                clouterReader.getRole(),
                clouterReader.getNickName(),
                clouterReader.getName(),
                clouterReader.getBirthday(),
                clouterReader.getAge(),
                clouterReader.getPhoneNumber(),
                clouterReader.getChannelList()
                                .stream().map(ChannelResponse::new).collect(Collectors.toList()),
                clouterReader.getMinCost(),
                clouterReader.getCategoryList(),
                clouterReader.getRegionList(),
                new AddressResponse(clouterReader.getAddress()),
                    clouterReader.getCountOfContract(),
                clouterReader.getImageResponses()
            )
        ).collect(Collectors.toList()));
    }

}
