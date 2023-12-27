package com.mmm.clout.memberservice.advertiser.domain;

import com.mmm.clout.memberservice.common.Role;
import com.mmm.clout.memberservice.common.entity.address.Address;
import com.mmm.clout.memberservice.member.domain.Member;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Embedded;
import javax.persistence.Entity;

@Getter
@ToString
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@SuperBuilder
@DynamicInsert
@DiscriminatorValue("AD")
@Entity
public class Advertiser extends Member {

    @Embedded
    private Address address;

    @Embedded
    private CompanyInfo companyInfo;

    public Advertiser(String userid, String pwd, Address address, CompanyInfo companyInfo) {
        super(userid, pwd, Role.ADVERTISER);
        this.address = address;
        this.companyInfo = companyInfo;
    }

    public static Advertiser create(String userId, String pwd, Address address, CompanyInfo companyInfo) {
        Advertiser advertiser = new Advertiser(userId, pwd, address, companyInfo);
        return advertiser;
    }

    public Advertiser update(String pwd, Address address, CompanyInfo companyInfo) {
        super.update(pwd);
        this.address = address;
        this.companyInfo = companyInfo;
        return this;
    }

    public Advertiser changePassword(String pwd) {
        super.changePwd(pwd);
        return this;
    }
}
