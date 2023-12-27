package com.mmm.clout.pointservice.point.application.command;

import com.mmm.clout.pointservice.point.domain.BankType;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class WithdrawCommand {

    private BankType bankType; // 은행 종류

    private Long accountNumber; // 계좌번호

    private Long withdrawingPoint; // 출금할 포인트 (신청한 포인트)

    private Long commission; // 수수료

    private Long totalReducingPoint; // 총차감금액

}
