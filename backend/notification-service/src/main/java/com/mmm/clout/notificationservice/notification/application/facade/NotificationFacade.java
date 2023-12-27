package com.mmm.clout.notificationservice.notification.application.facade;

import com.mmm.clout.notificationservice.notification.application.CheckMemberTokenProcessor;
import com.mmm.clout.notificationservice.notification.application.command.CheckMemberTokenCommand;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class NotificationFacade {

    private final CheckMemberTokenProcessor checkMemberTokenProcessor;

    public void check(CheckMemberTokenCommand command) {
        checkMemberTokenProcessor.execute(command);
    }
}
