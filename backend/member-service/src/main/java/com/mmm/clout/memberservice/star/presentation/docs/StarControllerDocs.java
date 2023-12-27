package com.mmm.clout.memberservice.star.presentation.docs;

import com.mmm.clout.memberservice.clouter.presentation.request.CreateClrRequest;
import com.mmm.clout.memberservice.clouter.presentation.request.UpdateClrRequest;
import com.mmm.clout.memberservice.clouter.presentation.response.CreateClrResponse;
import com.mmm.clout.memberservice.clouter.presentation.response.SelectClrResponse;
import com.mmm.clout.memberservice.clouter.presentation.response.UpdateClrResponse;
import com.mmm.clout.memberservice.star.presentation.request.createStarDetailRequest;
import com.mmm.clout.memberservice.star.presentation.response.CreateStarResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

@Tag(name = "별점 CRUD", description = "별점을 관리하는 api")
public interface StarControllerDocs {


    @Operation(summary = "별점 주기 api",
        responses =
        @ApiResponse(responseCode = "201", description = "생성된 별점 디테일 id 리턴",
            content =
            @Content(mediaType="application/json",
                schema=@Schema(implementation=CreateStarResponse.class))
        )
    )
    public ResponseEntity<CreateStarResponse> createStarScore(
        @RequestBody createStarDetailRequest requst
    );
}
