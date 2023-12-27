package com.mmm.clout.notificationservice.notification.application;

import com.mmm.clout.notificationservice.notification.application.command.CheckMemberTokenCommand;
import com.mmm.clout.notificationservice.notification.domain.entity.MemberFcmToken;
import com.mmm.clout.notificationservice.notification.domain.repository.MemberFcmTokenRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
public class CheckMemberTokenProcessor {

    private final MemberFcmTokenRepository memberFcmTokenRepository;

    @Transactional
    public MemberFcmToken execute(CheckMemberTokenCommand command) {
        return memberFcmTokenRepository.findByMemberIdAndDeviceId(
                command.getMemberId(), command.getDeviceId())
            .map(existingToken -> {
                // 토큰이 변경되었는지 확인
                if (!existingToken.getFcmToken().equals(command.getFcmToken())) {
                    existingToken.updateToken(command.getFcmToken());
                }
                return memberFcmTokenRepository.save(existingToken);
            })
            .orElseGet(() ->
                memberFcmTokenRepository.save(
                    MemberFcmToken.create(command.getMemberId(), command.getDeviceId(), command.getFcmToken())
                )
            );
    }


}
