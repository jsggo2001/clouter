package com.mmm.clout.contractservice.contract.domain;

import com.mmm.clout.contractservice.common.State;
import com.mmm.clout.contractservice.common.entity.BaseEntity;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Contract extends BaseEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "contract_id")
    private Long id;

    private Long applyId;

    private String name;

    private Long price;

    private String postDeadline;

    private String contractExpiration;

    private String contents;

    @Embedded
    private ClouterInfo clouterInfo;

    @Embedded
    private AdvertiserInfo advertiserInfo;

    @Enumerated(EnumType.STRING)
    private State state;

    private String path;

    public Contract(String name, Long applyId, Long price, String postDeadline, String contractExpiration, String contents, ClouterInfo clouterInfo, AdvertiserInfo advertiserInfo, String path) {
        this.name = name;
        this.applyId = applyId;
        this.price = price;
        this.postDeadline = postDeadline;
        this.contractExpiration = contractExpiration;
        this.contents = contents;
        this.clouterInfo = clouterInfo;
        this.advertiserInfo = advertiserInfo;
        this.state = State.WAITING;
        this.path = path;
    }
    public static Contract create(String name, Long applyId, Long price, String postDeadline, String contractExpiration, String contents, ClouterInfo clouterInfo, AdvertiserInfo advertiserInfo, String path) {
        return new Contract(name, applyId, price,postDeadline,contractExpiration,contents,clouterInfo,advertiserInfo, path);
    }

    public Contract updateResidentRegistrationNumber(String rnn) {
        this.clouterInfo.updateResidentRegistrationNumber(rnn);
        return this;
    }

    public Contract updateState() {
        this.state = State.COMPLETE;
        return this;
    }
}
