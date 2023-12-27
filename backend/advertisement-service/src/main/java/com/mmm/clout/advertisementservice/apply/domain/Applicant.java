package com.mmm.clout.advertisementservice.apply.domain;

import javax.persistence.Embeddable;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Getter
@Embeddable
public class Applicant {

    private Long applicantId; // clouterId 인플루언서 id


}
