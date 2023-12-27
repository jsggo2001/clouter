package com.mmm.clout.memberservice.star.presentation;

import com.mmm.clout.memberservice.star.application.facade.StarFacade;
import com.mmm.clout.memberservice.star.presentation.docs.StarControllerDocs;
import com.mmm.clout.memberservice.star.presentation.request.createStarDetailRequest;
import com.mmm.clout.memberservice.star.presentation.response.CreateStarResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController
@RequestMapping("/v1/starts")
@RequiredArgsConstructor
public class StarController implements StarControllerDocs {

    private final StarFacade starFacade;

    @PostMapping
    public ResponseEntity<CreateStarResponse> createStarScore(
         @Valid @RequestBody createStarDetailRequest requst
    ) {
        CreateStarResponse result = CreateStarResponse.from(
            starFacade.starScoreAdd(requst.toCommand())
        );

        return new ResponseEntity<>(result, HttpStatus.CREATED);
    }

}
