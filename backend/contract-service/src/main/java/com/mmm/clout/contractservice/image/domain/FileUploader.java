package com.mmm.clout.contractservice.image.domain;

import com.mmm.clout.contractservice.contract.domain.Contract;
import org.springframework.core.io.UrlResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface FileUploader {
    public String upload(MultipartFile multipartFile,Long targetId) throws Exception;

    public boolean delete(String imagePath);

    public ResponseEntity<UrlResource> downloadImage(String originalFilename);

    void uploadContract(MultipartFile file, Contract contract) throws IOException;

}
