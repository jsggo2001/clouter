package com.mmm.clout.memberservice.clouter.presentation;

import com.mmm.clout.memberservice.clouter.application.command.SearchCondition;
import com.mmm.clout.memberservice.clouter.application.facade.ClouterFacade;
import com.mmm.clout.memberservice.clouter.application.reader.ClouterReader;
import com.mmm.clout.memberservice.clouter.domain.search.ClouterSort;
import com.mmm.clout.memberservice.clouter.presentation.docs.ClouterControllerDocs;
import com.mmm.clout.memberservice.clouter.presentation.request.CreateClrRequest;
import com.mmm.clout.memberservice.clouter.presentation.request.UpdateClrRequest;
import com.mmm.clout.memberservice.clouter.presentation.response.*;
import com.mmm.clout.memberservice.common.Category;
import com.mmm.clout.memberservice.common.Platform;
import com.mmm.clout.memberservice.common.Region;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/v1/clouters")
@RequiredArgsConstructor
@Slf4j
public class ClouterController implements ClouterControllerDocs{

    private final ClouterFacade clouterFacade;

    @PostMapping(value = "/signup", consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    public ResponseEntity<CreateClrResponse> create(
            @RequestPart CreateClrRequest createClrRequest,
            @RequestPart(value = "files", required = false) List<MultipartFile> fileList
            ) throws Exception {
        CreateClrResponse result = CreateClrResponse.from(
                clouterFacade.create(createClrRequest.toCommand(), fileList)
        );
        return new ResponseEntity<>(result, HttpStatus.CREATED);
    }

    @PostMapping(value = "/{clouterId}", consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    public ResponseEntity<UpdateClrResponse> update(
            @PathVariable("clouterId") Long clouterId,
            @RequestPart @Valid  UpdateClrRequest updateClrRequest,
            @RequestPart(value = "files") List<MultipartFile> fileList
    ) throws IOException {
        UpdateClrResponse result = UpdateClrResponse.from(
                clouterFacade.update(updateClrRequest.toCommand(clouterId), fileList)
        );
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @GetMapping("/{clouterId}")
    public ResponseEntity<SelectClrResponse> selectClouter(
            @PathVariable("clouterId") Long clouterId
    ) {
        SelectClrResponse result = SelectClrResponse.from(
                clouterFacade.select(clouterId)
        );
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @GetMapping("/noneAuth/{clouterId}")
    public ResponseEntity<SelectClrResponse> selectClouterForNoneAuth(
        @PathVariable("clouterId") Long clouterId
    ) {
        SelectClrResponse result = SelectClrResponse.from(
            clouterFacade.select(clouterId)
        );
        result.blur();
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @GetMapping("/{clouterId}/contract")
    public ResponseEntity<SelectClrResponse> selectClouterForContract(
            @PathVariable("clouterId") Long clouterId
    ) {
        SelectClrResponse result = SelectClrResponse.from(
                clouterFacade.selectForContract(clouterId)
        );
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @GetMapping("/top10")
    public ResponseEntity<SelectTop10Response> getClouterTop10() {
        SelectTop10Response response = SelectTop10Response.from(
            clouterFacade.selectTop10()
        );
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/search")
    public ResponseEntity<CustomPageResponse<ClouterReader>> searchAndReadCampaignList(
        @RequestParam(defaultValue = "0") Integer page,
        @RequestParam(defaultValue = "10") Integer size,
        @RequestParam(defaultValue = "ALL") List<Category> category,
        @RequestParam(defaultValue = "INSTAGRAM") List<Platform> platform,
        @RequestParam(defaultValue = "0") Integer minAge,
        @RequestParam(defaultValue = "100") Integer maxAge,
        @RequestParam(defaultValue = "0") Integer minFollower,
        @RequestParam(defaultValue = "0") Integer minPrice,
        @RequestParam(defaultValue = "1000000000") Integer maxPrice,
        @RequestParam(defaultValue = "ALL") List<Region> region,
        @RequestParam(required = false) String keyword,
        @RequestParam(defaultValue = "SCORE") ClouterSort sortKey
    ) {

        Page<ClouterReader> searched = clouterFacade.search(
            PageRequest.of(page, size),
            SearchCondition.from(
                category,
                platform,
                minAge,
                maxAge,
                minFollower,
                minPrice,
                maxPrice,
                region,
                keyword,
                sortKey
            )
        );

        CustomPageResponse<ClouterReader> result = new CustomPageResponse<>(
            searched.toList(),
            searched.getNumber(),
            searched.getSize(),
            searched.getTotalPages(),
            searched.getTotalElements()
        );
        return new ResponseEntity<>(
            result, HttpStatus.OK);
    }
}
