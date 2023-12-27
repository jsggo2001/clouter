package com.mmm.clout.advertisementservice.advertisements.persentation.response;

import com.mmm.clout.advertisementservice.common.msa.info.AddressInfo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class AddressResponse {

    @Schema(description = "우편번호")
    private String zipCode;

    @Schema(description = "도로명/지번 주소")
    private String mainAddress;

    @Schema(description = "상세 주소")
    private String detailAddress;

    public static AddressResponse from(AddressInfo info) {
        return new AddressResponse(
            info.getZipCode(),
            info.getMainAddress(),
            info.getDetailAddress()
        );

    }
}
