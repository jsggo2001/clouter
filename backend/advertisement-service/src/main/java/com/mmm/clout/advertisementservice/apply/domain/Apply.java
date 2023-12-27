package com.mmm.clout.advertisementservice.apply.domain;

import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.apply.domain.exception.CancelApplyException;
import com.mmm.clout.advertisementservice.apply.domain.exception.CannotCancelApplyException;
import com.mmm.clout.advertisementservice.common.entity.BaseEntity;
import com.mmm.clout.advertisementservice.common.exception.ErrorCode;
import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
import org.hibernate.annotations.DynamicInsert;

@Getter
@ToString
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@DynamicInsert
@Table(name = "apply")
@Entity
public class Apply extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "apply_id")
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "advertisement_id")
    private Campaign campaign;

    @Embedded
    private Applicant applicant;

    @Column(length = 310)
    private String applyMessage;

    private Long hopeAdFee;

    private LocalDateTime appliedAt;

    @Enumerated(EnumType.STRING)
    private ApplyStatus applyStatus;

    public static Apply create(Campaign campaign, Applicant applicant, String applyMessage,
        Long hopeAdFee) {
        campaign.validApplyStatus();
        campaign.apply();
        return new Apply(campaign, applicant, applyMessage, hopeAdFee);
    }

    public Apply(Campaign campaign, Applicant applicant, String applyMessage, Long hopeAdFee) {
        this.campaign = campaign;
        this.applicant = applicant;
        this.applyMessage = applyMessage;
        this.hopeAdFee = hopeAdFee;
        this.appliedAt = LocalDateTime.now();
        this.applyStatus = ApplyStatus.WAITING;
    }

    public static boolean invalid(Apply apply) {
        return apply == null || apply.getApplyStatus() == Apply.ApplyStatus.CANCEL;
    }


    public void cancelApply() {
        if (this.applyStatus == ApplyStatus.ACCEPTED) {
            throw new CannotCancelApplyException("해당 캠페인은 이미 채택되어 취소할 수 없습니다.",
                ErrorCode.ALREADY_ACCEPTED_APPLY);
        }
        this.getCampaign().cancel();
        this.applyStatus = ApplyStatus.CANCEL;
    }

    public void end() {
        if (this.applyStatus == ApplyStatus.WAITING) {
            this.applyStatus = ApplyStatus.NOT_ACCEPTED;
        }
    }

    public void askForContract() {
        if (this.applyStatus == ApplyStatus.CANCEL) {
            throw new CancelApplyException();
        }
        this.applyStatus = ApplyStatus.ACCEPTED;
        this.campaign.selectClouter();
    }

    @Getter
    @RequiredArgsConstructor
    public enum ApplyStatus {

        WAITING("채택 대기"),
        ACCEPTED("채택"),
        NOT_ACCEPTED("미채택"),
        CANCEL("신청 취소");

        private final String description;
    }

    public ApplyStatus convertToApplyStatus(String applyStatus) {
        return ApplyStatus.valueOf(applyStatus.toUpperCase());
    }

}
