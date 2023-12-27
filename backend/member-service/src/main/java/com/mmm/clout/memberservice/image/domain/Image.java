package com.mmm.clout.memberservice.image.domain;

import com.mmm.clout.memberservice.member.domain.Member;
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
    @ManyToOne
    @JoinColumn(name="member_id", referencedColumnName = "member_id")
    private Member member;


    public Image(Member member, String originalName, String path, String imageName) {
        this.member = member;
        this.path = path;
        this.imageName = imageName;
        this.originalName = originalName;
    }

    public static Image create(
            Member member,
            String originalName,
            String path,
            String imageName
    ){
        return new Image(
                member,
                originalName,
                path,
                imageName
        );
    }
}
