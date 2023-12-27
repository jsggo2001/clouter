package com.mmm.clout.advertisementservice.image.presentation;

import com.mmm.clout.advertisementservice.image.domain.AdvertiseSign;
import com.mmm.clout.advertisementservice.image.domain.Image;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class AdvertiseSIgnResponse {

    @Schema(description = "image_id")
    private Long id;

    @Schema(description = "파일 원본 이름")
    private String originalName;

    @Schema(description = "이미지 경로")
    private String path;


    public AdvertiseSIgnResponse(AdvertiseSign signImage) {
        this.id = signImage.getId();
        this.originalName = signImage.getOriginalName();
        this.path = signImage.getPath();
    }

}
