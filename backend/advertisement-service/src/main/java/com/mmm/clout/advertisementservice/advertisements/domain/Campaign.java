package com.mmm.clout.advertisementservice.advertisements.domain;

import com.mmm.clout.advertisementservice.advertisements.domain.exception.AlreadyEndedException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.hibernate.Hibernate;
import org.hibernate.annotations.DynamicInsert;
import org.springframework.transaction.annotation.Transactional;

@Getter
@AllArgsConstructor
@DynamicInsert
@Table(name = "campaign")
@Entity
@DiscriminatorValue("CP")
public class Campaign extends Advertisement {

    @Column(name = "title", length = 60)
    private String title;

    @Enumerated(EnumType.STRING)
    private AdCategory adCategory; // 광고 카테고리

    private Boolean isPriceChangeable; // 광고비 협의 여부

    private Boolean isDeliveryRequired; // 배송 여부

    private Integer numberOfRecruiter; // 모집인원

    private Integer numberOfApplicants; // 신청인원

    private Integer numberOfSelectedMembers; // 채택 인원

    @Column(length = 600)
    private String offeringDetails; // 제공 내역 설명

    private String sellingLink; // 판매처 링크 (선택사항)

    private LocalDate applyStartDate; // 모집 시작 날짜

    private LocalDate applyEndDate; // 모집 종료 날짜

    private Integer minClouterAge; // 최소 클라우터 나이

    private Integer maxClouterAge; // 최대 클라우터 나이

    private Integer minFollower; // 최소 팔로워 수

    @Column(name = "is_ended")
    private Boolean isEnded; // 모집 종료 여부

    @ElementCollection(targetClass = Region.class, fetch = FetchType.LAZY)
    @CollectionTable(name = "advertisement_region", joinColumns = @JoinColumn(name = "advertisement_id"))
    @Enumerated(EnumType.STRING)
    @Column(name = "region")
    private List<Region> regionList = new ArrayList<>();

    @Transactional(readOnly = true)
    public Campaign initialize() {
        Hibernate.initialize(this.getRegionList());
        Hibernate.initialize(this.getAdPlatformList());
        return this;
    }

    protected Campaign() {
        super();
    }

    public void validApplyStatus() {
        if (this.applyEndDate.isBefore(LocalDate.now())) {
            throw new AlreadyEndedException();
        }
        if (this.numberOfRecruiter - this.numberOfSelectedMembers <= 0) {
            throw new AlreadyEndedException();
        }
    }

    public void apply() {
        this.numberOfApplicants++;
    }

    public void cancel() {
        this.numberOfApplicants--;
    }

    public Campaign(
        Long registerId,
        List<AdPlatform> adPlatformList,
        Long price,
        String details,
        String title,
        AdCategory category,
        Boolean isPriceChangeable,
        Boolean isDeliveryRequired,
        Integer numberOfRecruiter,
        String offeringDetails,
        String sellingLink,
        Integer minClouterAge,
        Integer maxClouterAge,
        Integer minFollower,
        List<Region> regionList
    ) {
        super(
            registerId,
            adPlatformList,
            price,
            details
        );

        this.title = title;
        this.adCategory = category;
        this.isPriceChangeable = isPriceChangeable;
        this.isDeliveryRequired = isDeliveryRequired;
        this.numberOfRecruiter = numberOfRecruiter;
        this.numberOfApplicants = 0;
        this.numberOfSelectedMembers = 0;
        this.offeringDetails = offeringDetails;
        this.sellingLink = sellingLink;
        this.minClouterAge = minClouterAge;
        this.maxClouterAge = maxClouterAge;
        this.minFollower = minFollower;
        this.applyStartDate = LocalDate.now();
        this.applyEndDate = this.applyStartDate.plusMonths(1);
        this.regionList = regionList;
        this.isEnded = false;
    }

    public static Campaign create(
        Long registerId,
        List<AdPlatform> adPlatformList,
        Long price,
        String details,
        String title,
        AdCategory category,
        Boolean isPriceChangeable,
        Boolean isDeliveryRequired,
        Integer numberOfRecruiter,
        String offeringDetails,
        String sellingLink,
        Integer minClouterAge,
        Integer maxClouterAge,
        Integer minFollower,
        List<Region> regionList
    ) {
        return new Campaign(
            registerId,
            adPlatformList,
            price,
            details,
            title,
            category,
            isPriceChangeable,
            isDeliveryRequired,
            numberOfRecruiter,
            offeringDetails,
            sellingLink,
            minClouterAge,
            maxClouterAge,
            minFollower,
            regionList
        );
    }

    public void update(
        List<AdPlatform> adPlatformList,
        long price,
        String details,
        String title,
        AdCategory adCategory,
        boolean priceChangeable,
        boolean deliveryRequired,
        int numberOfRecruiter,
        String offeringDetails,
        String sellingLink,
        int minClouterAge,
        int maxClouterAge,
        int minFollower,
        List<Region> regionList
    ) {
        super.update(adPlatformList, price, details);
        this.title = title;
        this.adCategory = adCategory;
        this.isPriceChangeable = priceChangeable;
        this.isDeliveryRequired = deliveryRequired;
        this.numberOfRecruiter = numberOfRecruiter;
        this.offeringDetails = offeringDetails;
        this.sellingLink = sellingLink;
        this.minClouterAge = minClouterAge;
        this.maxClouterAge = maxClouterAge;
        this.minFollower = minFollower;
        this.regionList = regionList;
    }

    public void softDelete() {
        super.softDelete();
    }

    @Override
    public Long getAdvertiserId() {
        return super.getAdvertiserId();
    }

    public void end() {
        this.applyEndDate = LocalDate.now();
        this.isEnded = true;
    }

    public void selectClouter() {
        this.numberOfSelectedMembers++;
    }
}
