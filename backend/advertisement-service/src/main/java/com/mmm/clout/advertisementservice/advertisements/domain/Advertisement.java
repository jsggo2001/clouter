package com.mmm.clout.advertisementservice.advertisements.domain;

import com.mmm.clout.advertisementservice.common.entity.BaseEntity;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.Table;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.Where;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@DynamicInsert
@Table(name = "advertisement")
@Where(clause = "deleted_at is null")
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name = "DTYPE")
@Entity
public abstract class Advertisement extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "advertisement_id")
    private Long id;

    @Column(name = "register_id")
    private Long registerId; // 광고 등록자 (광고주)

    @ElementCollection(targetClass = AdPlatform.class, fetch = FetchType.LAZY)
    @CollectionTable(name = "advertisement_platform", joinColumns = @JoinColumn(name = "advertisement_id"))
    @Enumerated(EnumType.STRING)
    @Column(name = "platform")
    private List<AdPlatform> adPlatformList = new ArrayList<>(); // 광고 플랫폼 리스트

    @Column(name = "price")
    private Long price; // 광고비

    @Column(name = "details", length = 1000)
    private String details; // 광고 상세설명

    @Column(name = "deleted_at")
    private LocalDateTime deletedAt; // 광고 삭제여부

    public Advertisement(
        Long registerId,
        List<AdPlatform> adPlatformList,
        Long price,
        String details
    ) {
        this.registerId = registerId;
        this.adPlatformList = adPlatformList;
        this.price = price;
        this.details = details;
    }

    protected void update(List<AdPlatform> adPlatformList, long price, String details) {
        this.adPlatformList = adPlatformList;
        this.price = price;
        this.details = details;
    }

    protected void softDelete() {
        this.deletedAt = LocalDateTime.now();
    }

    public Long getAdvertiserId() {
        return this.registerId;
    }
}

