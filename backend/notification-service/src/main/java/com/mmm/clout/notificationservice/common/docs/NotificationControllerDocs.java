package com.mmm.clout.notificationservice.common.docs;

import com.mmm.clout.notificationservice.notification.presentation.request.CheckMemberTokenRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;

@Tag(name = "알림 api", description = "알림 관련 api")
public interface NotificationControllerDocs {

    @Operation(summary = "멤버 알림 fcm 토큰 생성 혹은 변경 체크 api",
        description = "memberId, deviceId, fcmtoken을 받아 토큰 변경 감지 체크 및 업데이트 혹은 생성합니다.",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            content = @Content(mediaType = "application/json",
                schema = @Schema(implementation = CheckMemberTokenRequest.class)),
            description = "멤버 fcm 토큰 생성 혹은 변경 체크를 위한 정보",
            required = true
        )
    )
    ResponseEntity<Void> checkMemberToken(
        @RequestBody @Valid CheckMemberTokenRequest request
    );
}