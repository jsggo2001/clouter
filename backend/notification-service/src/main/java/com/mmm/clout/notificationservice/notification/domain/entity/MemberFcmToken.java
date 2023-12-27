package com.mmm.clout.notificationservice.notification.domain.entity;

import com.mmm.clout.notificationservice.common.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicInsert;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@DynamicInsert
@Table(name = "member_fcm_token")
@Entity
public class MemberFcmToken extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_fcm_token_id")
    private Long id;

    @Column(name = "member_id")
    private Long memberId;

    @Column(name = "device_id")
    private String deviceId;

    @Column(name = "fcm_token")
    private String fcmToken;

    @Column(name = "status")
    private Boolean status;

    @Column(name = "app_version")
    private String appVersion;

    public MemberFcmToken(Long memberId, String deviceId, String fcmToken) {
        this.memberId = memberId;
        this.deviceId = deviceId;
        this.fcmToken = fcmToken;
        this.status = true;
        this.appVersion = "1.0";
    }


    public static MemberFcmToken create(Long memberId, String deviceId, String fcmToken) {
        return new MemberFcmToken(memberId, deviceId, fcmToken);
    }

    public void updateToken(String fcmToken) {
        this.fcmToken = fcmToken;
    }
}
