package com.mmm.clout.contractservice.contract.presentation;

import com.mmm.clout.contractservice.contract.application.facade.ContractFacade;
import com.mmm.clout.contractservice.contract.application.reader.ContractReader;
import com.mmm.clout.contractservice.contract.presentation.docs.ContractControllerDocs;
import com.mmm.clout.contractservice.contract.presentation.request.CreateContractRequest;
import com.mmm.clout.contractservice.contract.presentation.request.UpdateRRNContractRequest;
import com.mmm.clout.contractservice.contract.presentation.response.*;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/v1/contracts")
@RequiredArgsConstructor
public class ContractController implements ContractControllerDocs {

    private final ContractFacade contractFacade;

    @PostMapping
    public ResponseEntity<CreateContractResponse> create(
            @RequestBody @Valid CreateContractRequest createAdrRequest
    ) {
        CreateContractResponse result = CreateContractResponse.from(
                contractFacade.create(createAdrRequest.toCommand())
        );
        return new ResponseEntity<>(result, HttpStatus.CREATED);
    }

    @PatchMapping("/{contractId}")
    public ResponseEntity<UpdateRRNContractResponse> updateRNN(
            @PathVariable("contractId") Long id,
            @RequestBody UpdateRRNContractRequest request
            ) {
        UpdateRRNContractResponse response = UpdateRRNContractResponse.from(
                contractFacade.updateRRN(id, request.getResidentRegistrationNumber())
        );
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PatchMapping(value = "/{contractId}/complete", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
    public ResponseEntity<UpdateStateContractResponse> updateState(
            @PathVariable("contractId") Long id,
            @RequestPart(value = "files", required = false) MultipartFile file
    ) throws Exception {
        UpdateStateContractResponse response = UpdateStateContractResponse.from(
                contractFacade.updateState(id, file)
        );
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @DeleteMapping("/{contractId}")
    public ResponseEntity<DeleteContractResponse> delete(
            @PathVariable("contractId") Long id
    ) {
        DeleteContractResponse response = DeleteContractResponse.from(
                contractFacade.delete(id)
        );
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/{contractId}")
    public ResponseEntity<ContractReader> select(
            @PathVariable("contractId") Long id
    ) {
        ContractReader response = ContractReader.from(
                contractFacade.select(id)
        );
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/clouter")
    public ResponseEntity<CustomPageResponse<ContractReader>> selectClouter(
            @RequestParam(defaultValue = "0") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam("clouterId") Long clouterId
    ) {
        Page<ContractReader> searched = contractFacade.selectAllClouter(clouterId, PageRequest.of(page, size));

        CustomPageResponse response = new CustomPageResponse(
            searched.toList(),
            searched.getNumber(),
            searched.getSize(),
            searched.getTotalPages(),
            searched.getTotalElements()
        );
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/advertiser")
    public ResponseEntity<CustomPageResponse<ContractReader>> selectAdvertiser(
            @RequestParam(defaultValue = "0") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam("advertiserId") Long advertiserId
    ) {

        Page<ContractReader> searched = contractFacade.selectAllAdvertiser(advertiserId, PageRequest.of(page, size));

        CustomPageResponse response = new CustomPageResponse(
            searched.toList(),
            searched.getNumber(),
            searched.getSize(),
            searched.getTotalPages(),
            searched.getTotalElements()
        );
        
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
    @GetMapping("/file/{contractId}")
    public ResponseEntity<String> selectFile(
            @PathVariable("contractId") Long id
    ) {
        String path = contractFacade.getContractFile(id);
        return new ResponseEntity<>(path, HttpStatus.OK);
    }
}
