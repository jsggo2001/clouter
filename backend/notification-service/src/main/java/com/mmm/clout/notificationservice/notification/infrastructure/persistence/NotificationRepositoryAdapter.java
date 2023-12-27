package com.mmm.clout.notificationservice.notification.infrastructure.persistence;

import com.mmm.clout.notificationservice.notification.domain.entity.MemberFcmToken;
import com.mmm.clout.notificationservice.notification.domain.repository.MemberFcmTokenRepository;
import com.mmm.clout.notificationservice.notification.infrastructure.persistence.jpa.JpaMemberFcmTokenRepository;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class NotificationRepositoryAdapter implements MemberFcmTokenRepository {

    private final JpaMemberFcmTokenRepository jpaMemberFcmTokenRepository;


    @Override
    public MemberFcmToken save(MemberFcmToken memberFcmToken) {
        return jpaMemberFcmTokenRepository.save(memberFcmToken);
    }

    @Override
    public Optional<MemberFcmToken> findByMemberIdAndDeviceId(Long memberId, String deviceId) {
        return jpaMemberFcmTokenRepository.findByMemberIdAndDeviceId(memberId, deviceId);
    }
}
