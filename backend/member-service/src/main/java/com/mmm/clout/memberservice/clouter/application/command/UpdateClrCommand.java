package com.mmm.clout.memberservice.clouter.application.command;

import com.mmm.clout.memberservice.common.Category;
import com.mmm.clout.memberservice.common.Region;
import com.mmm.clout.memberservice.common.entity.address.command.AddressCommand;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.time.LocalDate;
import java.util.List;

@Getter
@AllArgsConstructor
public class UpdateClrCommand {
    private Long ClouterId;

    private String pwd;

    private String nickName;

    private String name;

    private LocalDate birthday;

    private Integer age;

    private String phoneNumber;

    private List<ChannelCommand> channelList;

    private Long minCost;

    private List<Category> categoryList;

    private List<Region> regionList;

    private AddressCommand address;
}
