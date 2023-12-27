//package com.mmm.clout.memberservice.image.infrastructure.config;
//
//import com.mmm.clout.imageservice.image.application.DeleteImageProcessor;
//import com.mmm.clout.imageservice.image.application.DownloadImageProcessor;
//import com.mmm.clout.imageservice.image.application.FindImageProcessor;
//import com.mmm.clout.imageservice.image.application.UploadImageProcessor;
//import com.mmm.clout.imageservice.image.domain.FileUploader;
//import com.mmm.clout.imageservice.image.domain.repository.ImageRepository;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//
//@Configuration
//public class ImageConfig {
//    @Bean
//    public UploadImageProcessor uploadImageProcessor(ImageRepository imageRepository, FileUploader fileUploader) {
//        return new UploadImageProcessor(imageRepository, fileUploader);
//    }
//
//    @Bean
//    public FindImageProcessor findImageProcessor(ImageRepository imageRepository) {
//        return new FindImageProcessor(imageRepository);
//    }
//
//    @Bean
//    public DeleteImageProcessor deleteImageProcessor(ImageRepository imageRepository, FileUploader fileUploader){
//        return new DeleteImageProcessor(imageRepository, fileUploader);
//    }
//
//    @Bean
//    public DownloadImageProcessor downloadImageProcessor(ImageRepository imageRepository, FileUploader fileUploader){
//        return new DownloadImageProcessor(imageRepository, fileUploader);
//    }
//
//}
