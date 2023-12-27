package com.mmm.clout.memberservice.image.infrastructure.persistance.jpa;

import com.mmm.clout.memberservice.image.domain.Image;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface JpaImageRepository extends JpaRepository<Image, Long> {

        List<Image> findByMember_Id(Long Id);

        List<Image> findByMember_IdIn(List<Long> ids);

}
