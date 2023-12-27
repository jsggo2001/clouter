package com.mmm.clout.pointservice.point.domain;

import com.mmm.clout.pointservice.common.entity.BaseEntity;
import com.mmm.clout.pointservice.point.domain.exception.LackOfPointException;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.hibernate.annotations.DynamicInsert;

@ToString
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@DynamicInsert
@Table(name = "point", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"member_id"})
})
@Entity
public class Point extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "point_id")
    private Long id;

    @Column(name = "member_id")
    private Long memberId;

    @Column(name = "total_point")
    private Long totalPoint;

    public Point(Long memberId, Long totalPoint) {
        this.memberId = memberId;
        this.totalPoint = totalPoint;
    }

    public static Point create(Long memberId, Long point) {
        return new Point(memberId, point);
    }

    public void add(Long point) {
        this.totalPoint += point;
    }

    public void reduce(Long reducingPoint) {
        if (this.totalPoint - reducingPoint < 0) {
            throw new LackOfPointException();
        }
        this.totalPoint -= reducingPoint;
    }
}
