package com.mmm.clout.notificationservice.notification.infrastructure.persistence.jpa;

import com.mmm.clout.notificationservice.notification.domain.entity.MemberFcmToken;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface JpaMemberFcmTokenRepository extends JpaRepository<MemberFcmToken, Long> {

    Optional<MemberFcmToken> findByMemberIdAndDeviceId(Long memberId, String deviceId);
}
