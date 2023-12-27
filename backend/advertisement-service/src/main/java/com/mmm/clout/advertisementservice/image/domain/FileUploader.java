package com.mmm.clout.advertisementservice.image.domain;

import com.mmm.clout.advertisementservice.advertisements.domain.Advertisement;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import org.springframework.core.io.UrlResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface FileUploader {
    public String upload(MultipartFile multipartFile,Long targetId) throws Exception;

    public String uploadSign(MultipartFile multipartFile,Campaign campaign) throws Exception;

    public boolean delete(String imagePath);

    public ResponseEntity<UrlResource> downloadImage(String originalFilename);

    void uploadList(List<MultipartFile> files, Campaign campaign) throws IOException;

}
