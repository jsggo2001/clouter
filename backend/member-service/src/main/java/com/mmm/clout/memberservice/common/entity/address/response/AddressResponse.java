package com.mmm.clout.memberservice.common.entity.address.response;

import com.mmm.clout.memberservice.common.entity.address.Address;
import com.mmm.clout.memberservice.common.entity.address.reader.AddressReader;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class AddressResponse {

    @Schema(description = "우편 번호")
    private String zipCode;

    @Schema(description = "메인 주소")
    private String mainAddress;

    @Schema(description = "상세 주소")
    private String detailAddress;

    public AddressResponse(AddressReader addressReader) {
        this.zipCode = addressReader.getZipCode();
        this.mainAddress = addressReader.getMainAddress();
        this.detailAddress = addressReader.getDetailAddress();
    }

    public AddressResponse(Address address) {
        this.zipCode = address.getZipCode();
        this.mainAddress = address.getMainAddress();
        this.detailAddress = address.getDetailAddress();
    }

    public void blur() {
        this.zipCode = "@@@@@";
        this.mainAddress = "@@@@@";
        this.detailAddress = "@@@@@";
    }
}
