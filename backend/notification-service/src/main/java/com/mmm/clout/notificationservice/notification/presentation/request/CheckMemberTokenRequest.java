package com.mmm.clout.notificationservice.notification.presentation.request;

import com.mmm.clout.notificationservice.notification.application.command.CheckMemberTokenCommand;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CheckMemberTokenRequest {

    @NotNull
    private Long memberId;

    @NotBlank
    private String deviceId;

    @NotBlank
    private String fcmToken;

    public CheckMemberTokenCommand toCommand() {
        return new CheckMemberTokenCommand(memberId, deviceId, fcmToken);
    }
}
