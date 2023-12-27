package com.mmm.clout.memberservice.clouter.application;

import com.mmm.clout.memberservice.clouter.application.command.UpdateClrCommand;
import com.mmm.clout.memberservice.clouter.domain.Clouter;
import com.mmm.clout.memberservice.clouter.domain.repository.ClouterRepository;
import com.mmm.clout.memberservice.image.domain.FileUploader;
import com.mmm.clout.memberservice.image.domain.Image;
import com.mmm.clout.memberservice.image.domain.repository.ImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
public class UpdateClouterProcessor {

    private final ClouterRepository clouterRepository;
    private final BCryptPasswordEncoder encoder;
    private final ImageRepository imageRepository;
    private final FileUploader fileUploader;

    @Transactional
    public Clouter execute(UpdateClrCommand command, List<MultipartFile> fileList) throws IOException {
        Clouter clouter = clouterRepository.findById(command.getClouterId());
        clouter.update(
            command.getPwd(),
            command.getNickName(),
            command.getName(),
            command.getBirthday(),
            command.getAge(),
            command.getPhoneNumber(),
            command.getChannelList().stream().map(v -> v.toValueType()).collect(Collectors.toList()),
            command.getMinCost(),
            command.getCategoryList(),
            command.getRegionList(),
            command.getAddress().toValueType()
        );
        clouter.changePwd(encoder.encode(clouter.getPwd()));

        List<Image> images = imageRepository.findByMemberId(clouter.getId());
        images.stream()
            .map(v->fileUploader.delete(v.getPath()))
            .collect(Collectors.toList());
        //db에서 사진 삭제
        for(Image a : images){
            imageRepository.deleteImage(a.getId());
        }

        fileUploader.uploadList(fileList, clouter);

        return clouter;
    }

}
