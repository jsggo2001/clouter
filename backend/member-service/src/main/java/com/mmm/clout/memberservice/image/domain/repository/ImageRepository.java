package com.mmm.clout.memberservice.image.domain.repository;

import com.mmm.clout.memberservice.image.domain.Image;

import java.util.List;

public interface ImageRepository {

    Image save(Image image);

    List<Image> findByMemberId(Long memberId);

    Image delete(Long id);

    Image find(Long id);

    List<Image> findByIdIn(List<Long> ids);

    void deleteImage(Long id);
}
