package com.mmm.clout.advertisementservice.image.domain;

import com.mmm.clout.advertisementservice.advertisements.domain.Advertisement;
import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.sun.istack.NotNull;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Getter
@ToString
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@SuperBuilder
@DynamicInsert
@Table(name = "image")
@Entity
public class Image {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @NotNull
    @Column(name = "original_name")
    private String originalName;

    @NotNull
    @Column(name = "path")
    private String path;

    @NotBlank
    @Column(name = "image_name")
    private String imageName;
    //시간 + 난수생성 + 오리지널

    @NotNull
    @ManyToOne()
    @JoinColumn(name="advertisement_id", referencedColumnName = "advertisement_id")
    private Campaign campaign;


    public Image(Campaign campaign, String originalName, String path, String imageName) {
        this.campaign = campaign;
        this.path = path;
        this.imageName = imageName;
        this.originalName = originalName;
    }

    public static Image create(
            Campaign campaign,
            String originalName,
            String path,
            String imageName
    ){
        return new Image(
                campaign,
                originalName,
                path,
                imageName
        );
    }
}
