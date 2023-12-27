package com.mmm.clout.notificationservice.notification.domain.repository;

import com.mmm.clout.notificationservice.notification.domain.entity.MemberFcmToken;
import java.util.Optional;

public interface MemberFcmTokenRepository {

    MemberFcmToken save(MemberFcmToken memberFcmToken);

    Optional<MemberFcmToken> findByMemberIdAndDeviceId(Long memberId, String deviceId);

}
