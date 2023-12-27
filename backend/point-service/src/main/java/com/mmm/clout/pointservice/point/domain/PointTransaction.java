package com.mmm.clout.pointservice.point.domain;

import com.mmm.clout.pointservice.common.entity.BaseEntity;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicInsert;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@DynamicInsert
@Table(name = "point_transaction")
@Entity
public class PointTransaction extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "point_transaction_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "point_id")
    private Point point;

    @Column(name = "amount")
    private Long amount;

    @Enumerated(EnumType.STRING)
    @Column(name = "point_status")
    private PointStatus pointStatus;

    @Enumerated(EnumType.STRING)
    @Column(name = "point_category")
    private PointCategory pointCategory;

    // 반정규화
    @Column(name = "counterparty")
    private String counterparty;

    public PointTransaction(Point point, Long amount, PointStatus pointStatus,
        PointCategory pointCategory, String counterparty) {
        this.point = point;
        this.amount = amount;
        this.pointStatus = pointStatus;
        this.pointCategory = pointCategory;
        this.counterparty = counterparty;
    }

    public static PointTransaction charge(Point point, Long chargePoint) {
        return new PointTransaction(
            point,
            chargePoint,
            PointStatus.PLUS,
            PointCategory.CHARGE,
            PointCategory.CHARGE.getDescription()
        );
    }

    public static PointTransaction reduce(
        Point point,
        Long reducingPoint,
        PointCategory pointCategory,
        String counterParty
    ) {
        // 계약일 경우, 거래 상대방 표시
        if (pointCategory == PointCategory.CONTRACT
            || pointCategory == PointCategory.CANCEL_CONTRACT
        ) {
            return new PointTransaction(point, reducingPoint, PointStatus.MINUS, pointCategory, counterParty);
        }
        return new PointTransaction(point, reducingPoint, PointStatus.MINUS, pointCategory, pointCategory.getDescription());
    }

    public static PointTransaction add(Point point, Long addingPoint, PointCategory pointCategory, String counterParty) {
        // 계약일 경우, 거래 상대방 표시
        if (pointCategory == PointCategory.CONTRACT
            || pointCategory == PointCategory.CANCEL_CONTRACT
        ) {
            return new PointTransaction(point, addingPoint, PointStatus.PLUS, pointCategory, counterParty);
        }
        return new PointTransaction(point, addingPoint, PointStatus.PLUS, pointCategory, pointCategory.getDescription());
    }
}
