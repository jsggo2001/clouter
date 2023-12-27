package com.mmm.clout.contractservice.contract.domain.info;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class AddressInfo {

    private String zipCode;

    private String mainAddress;

    private String detailAddress;

//    public AddressResponse(AddressReader addressReader) {
//        this.zipCode = addressReader.getZipCode();
//        this.mainAddress = addressReader.getMainAddress();
//        this.detailAddress = addressReader.getDetailAddress();
//    }
//
//    public AddressResponse(Address address) {
//        this.zipCode = address.getZipCode();
//        this.mainAddress = address.getMainAddress();
//        this.detailAddress = address.getDetailAddress();
//    }
}
