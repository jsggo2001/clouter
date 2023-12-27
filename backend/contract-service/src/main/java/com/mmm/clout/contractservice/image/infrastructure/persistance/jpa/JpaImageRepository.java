package com.mmm.clout.contractservice.image.infrastructure.persistance.jpa;

import com.mmm.clout.contractservice.image.domain.Image;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface JpaImageRepository extends JpaRepository<Image, Long> {

        Image findByContract_Id(Long Id);

}
