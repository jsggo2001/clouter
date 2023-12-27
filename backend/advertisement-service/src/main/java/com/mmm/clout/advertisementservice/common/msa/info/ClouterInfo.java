package com.mmm.clout.advertisementservice.common.msa.info;

import java.time.LocalDate;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ClouterInfo {

    private Long clouterId;

    private String userId;

    private Long avgScore;

    private String role;

    private String nickName;

    private String name;

    private LocalDate birthday;

    private Integer age;

    private String phoneNumber;

    private List<ChannelInfo> channelList;

    private HopeCostInfo hopeCost;

    private boolean negoable;

    private List<String> categoryList;

    private List<String> regionList;

    private AddressInfo address;

}
