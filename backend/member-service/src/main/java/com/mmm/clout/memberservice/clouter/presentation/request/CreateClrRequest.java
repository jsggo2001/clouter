package com.mmm.clout.memberservice.clouter.presentation.request;

import com.mmm.clout.memberservice.common.Region;
import com.mmm.clout.memberservice.common.entity.address.request.AddressRequest;
import com.mmm.clout.memberservice.clouter.application.command.CreateClrCommand;
import com.mmm.clout.memberservice.common.Category;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@AllArgsConstructor
public class CreateClrRequest {

    @NotBlank
    @Schema(description = "클라우터 아이디", defaultValue = "clouter1")
    @Size(min = 5, max = 15)
    private String userId;

    @NotBlank
    @Schema(description = "클라우터 비밀번호")
    @Size(min = 8, max = 20)
    private String pwd;

    @NotBlank
    @Schema(description = "클라우터 닉네임임")
    @Size(max = 20)
    private String nickName;

    @NotBlank
    @Schema(description = "이름")
    @Size(max = 20)
    private String name;

    @NotNull
    @Schema(description = "생일")
    private LocalDate birthday;

    @NotNull
    @Schema(description = "나이")
    private Integer age;

    @NotBlank
    @Schema(description = "전화번호")
    @Size(max = 15)
    private String phoneNumber;

    @NotNull
    @Size(min = 1)
    @Schema(description = "개인 채널 리스트")
    private List<ChannelRequest> channelList;

    private Long minCost;

    @NotNull
    @Size(min = 1, message = "최소 1개의 카테고리는 선택 해야 합니다.")
    @Schema(description = "광고를 원하는 카테고리 목록")
    private List<Category> categoryList;

    @NotNull
    @Size(min = 1, message = "최소 1개의 지역은 선택 해야 합니다.")
    @Schema(description = "광고를 희망하는 지역 목록")
    private List<Region> regionList;

    private AddressRequest address;

    public CreateClrCommand toCommand() {
        return new CreateClrCommand(
                this.userId,
                this.pwd,
                this.nickName,
                this.name,
                this.birthday,
                this.age,
                this.phoneNumber,
                this.channelList.stream().map(ChannelRequest::toCommand).collect(Collectors.toList()),
                this.minCost,
                this.categoryList,
                this.regionList,
                this.address.toCommand()
        );
    }
}