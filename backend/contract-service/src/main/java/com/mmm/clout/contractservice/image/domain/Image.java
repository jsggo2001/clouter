package com.mmm.clout.contractservice.image.domain;

import com.mmm.clout.contractservice.contract.domain.Contract;
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
    @ManyToOne(cascade = CascadeType.REMOVE)
    @JoinColumn(name="contract_id", referencedColumnName = "contract_id")
    private Contract contract;


    public Image(Contract contract, String originalName, String path, String imageName) {
        this.contract = contract;
        this.path = path;
        this.imageName = imageName;
        this.originalName = originalName;
    }

    public static Image create(
            Contract contract,
            String originalName,
            String path,
            String imageName
    ){
        return new Image(
                contract,
                originalName,
                path,
                imageName
        );
    }
}
