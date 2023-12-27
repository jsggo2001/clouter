package com.mmm.clout.memberservice.image.domain;

import com.mmm.clout.memberservice.member.domain.Member;
import java.io.IOException;
import java.util.List;
import org.springframework.core.io.UrlResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

public interface FileUploader {
    public String upload(MultipartFile multipartFile,Long targetId) throws Exception;

    public boolean delete(String imagePath);

    public ResponseEntity<UrlResource> downloadImage(String originalFilename);

    void uploadList(List<MultipartFile> files, Member clouter) throws IOException;

}
