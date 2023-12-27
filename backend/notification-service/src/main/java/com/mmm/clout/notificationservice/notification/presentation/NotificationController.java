package com.mmm.clout.notificationservice.notification.presentation;

import com.mmm.clout.notificationservice.common.docs.NotificationControllerDocs;
import com.mmm.clout.notificationservice.notification.application.facade.NotificationFacade;
import com.mmm.clout.notificationservice.notification.presentation.request.CheckMemberTokenRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1/notifications")
@RequiredArgsConstructor
public class NotificationController implements NotificationControllerDocs {

    private final NotificationFacade notificationFacade;

    @PostMapping("/members/token-check")
    public ResponseEntity<Void> checkMemberToken(
        @RequestBody @Valid CheckMemberTokenRequest request
    ) {
        notificationFacade.check(request.toCommand());
        return new ResponseEntity<>(null, HttpStatus.CREATED);
    }
}
