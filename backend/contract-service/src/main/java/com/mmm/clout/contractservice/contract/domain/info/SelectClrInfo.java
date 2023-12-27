package com.mmm.clout.contractservice.contract.domain.info;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.time.LocalDate;
import java.util.List;

@Getter
@AllArgsConstructor
public class SelectClrInfo {

    private Long clouterId;

    private String userId;

    private Long avgScore;

    private Long totalPoint;

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
//
//    public SelectClrResponse(ClouterReader clouterReader) {
//
//        this.clouterId = clouterReader.getClouterId();
//
//        this.userId = clouterReader.getUserId();
//
//        this.avgScore = clouterReader.getAvgScore();
//
//        this.totalPoint = clouterReader.getTotalPoint();
//
//        this.role = clouterReader.getRole();
//
//        this.nickName = clouterReader.getNickName();
//        this.name = clouterReader.getName();
//        this.birthday = clouterReader.getBirthday();
//        this.age = clouterReader.getAge();
//        this.phoneNumber = clouterReader.getPhoneNumber();
//        this.channelList = clouterReader.getChannelList()
//            .stream().map(ChannelResponse::new).collect(Collectors.toList());
//        this.hopeCost = new HopeCostResponse(clouterReader.getHopeCost());
//        this.negoable = clouterReader.isNegoable();
//        this.categoryList = clouterReader.getCategoryList();
//        this.regionList = clouterReader.getRegionList();
//        this.address = new AddressResponse(clouterReader.getAddress());
//    }
//
//    public static SelectClrResponse from(ClouterReader clouterReader) {
//        SelectClrResponse response = new SelectClrResponse(clouterReader);
//        return response;
//    }
}
