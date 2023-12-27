package com.mmm.clout.memberservice.clouter.domain;

import com.mmm.clout.memberservice.common.Region;
import com.mmm.clout.memberservice.common.Role;
import com.mmm.clout.memberservice.common.entity.address.Address;
import com.mmm.clout.memberservice.common.Category;
import com.mmm.clout.memberservice.member.domain.Member;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Getter
@ToString
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@SuperBuilder
@DynamicInsert
@DiscriminatorValue("CT")
@Entity
public class Clouter extends Member {

    @Column(length = 30)
    private String nickName;

    @Column(length = 30)
    private String name;

    private LocalDate birthday;

    private Integer age;

    @Column(length = 20, unique = true)
    private String phoneNumber;

    @ElementCollection(fetch = FetchType.LAZY)
    @CollectionTable(name = "channel", joinColumns = @JoinColumn(name = "member_id"))
    private List<Channel> channelList = new ArrayList<>();

    private Long minCost;

    @ElementCollection(targetClass = Category.class, fetch = FetchType.LAZY)
    @JoinTable(name="clouter_categories", joinColumns = @JoinColumn(name = "member_id"))
    @Column(name = "category", nullable = false)
    @Enumerated(EnumType.STRING)
    private List<Category> categoryList = new ArrayList<>();

    @ElementCollection(targetClass = Region.class, fetch = FetchType.LAZY)
    @JoinTable(name="clouter_regions", joinColumns = @JoinColumn(name = "member_id"))
    @Column(name = "region", nullable = false)
    @Enumerated(EnumType.STRING)
    private List<Region> regionList = new ArrayList<>();

    @Embedded
    private Address address;

    public Clouter(String userid, String pwd, String nickName, String name, LocalDate birthday, Integer age,
                   String phoneNumber,List<Channel> channelList, Long minCost,
                   List<Category> categoryList,List<Region> regionList, Address address) {
        super(userid, pwd, Role.CLOUTER);
        this.nickName = nickName;
        this.name = name;
        this.birthday = birthday;
        this.age = age;
        this.phoneNumber = phoneNumber;
        this.channelList = channelList;
        this.minCost = minCost;
        this.categoryList = categoryList;
        this.regionList = regionList;
        this.address = address;
    }

    public static Clouter create(String userid, String pwd, String nickName, String name, LocalDate birthday, Integer age,
                                  String phoneNumber,List<Channel> channelList, Long minCost,
                                  List<Category> categoryList,List<Region> regionList, Address address) {
        Clouter clouter = new Clouter(userid,pwd,nickName,name,birthday,age,phoneNumber,channelList, minCost,
                                     categoryList, regionList, address);
        return clouter;
    }

    public Clouter update(String pwd, String nickName, String name, LocalDate birthday, Integer age,
                                 String phoneNumber, List<Channel> channelList, Long minCost ,
                                 List<Category> categoryList, List<Region> regionList, Address address) {
        super.update(pwd);
        this.nickName = nickName;
        this.name = name;
        this.birthday = birthday;
        this.age = age;
        this.phoneNumber = phoneNumber;
        this.channelList = channelList;
        this.minCost = minCost;
        this.categoryList = categoryList;
        this.regionList = regionList;
        this.address = address;
        return this;
    }

    public List<Category> allGetCategoryList() {
        return this.categoryList;
    }

    public List<Region> allGetRegionList() {
        return this.regionList;
    }

}
