package com.mmm.clout.memberservice.clouter.application.command;

import com.mmm.clout.memberservice.clouter.domain.Clouter;
import com.mmm.clout.memberservice.common.Region;
import com.mmm.clout.memberservice.common.entity.address.command.AddressCommand;
import com.mmm.clout.memberservice.common.Category;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@AllArgsConstructor
public class CreateClrCommand {

    private String userId;

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

    public Clouter toEntity() {
        return Clouter.create(
            this.userId,
            this.pwd,
            this.nickName,
            this.name,
            this.birthday,
            this.age,
            this.phoneNumber,
            this.channelList.stream().map(ChannelCommand::toValueType).collect(Collectors.toList()),
            this.minCost,
            this.categoryList,
            this.regionList,
            this.address.toValueType()
        );
    }
}
