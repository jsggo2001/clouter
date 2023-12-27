package com.mmm.clout.notificationservice.notification.application.command;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CheckMemberTokenCommand {

    private Long memberId;

    private String deviceId;

    private String fcmToken;

}
