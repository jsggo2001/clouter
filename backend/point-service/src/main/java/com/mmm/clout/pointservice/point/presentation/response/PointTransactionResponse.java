package com.mmm.clout.pointservice.point.presentation.response;

import com.mmm.clout.pointservice.point.domain.PointTransaction;
import io.swagger.v3.oas.annotations.media.Schema;
import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class PointTransactionResponse {

    @Schema(description = "포인트 내역 고유 식별자 (id)")
    private Long transactionId;

    @Schema(description = "포인트 고유 식별자 (id)")
    private Long pointId;

    @Schema(description = "멤버 고유 식별자 (id)")
    private Long memberId;

    @Schema(description = "내역 당 포인트")
    private Long amount;

    @Schema(description = "포인트 +/-")
    private String pointStatus;

    @Schema(description = "종류")
    private String category; // ALL, DEAL, CHARGE, WITHDRAWAL

    @Schema(description = "거래/사용처")
    private String counterparty; // 계약이면 계약 상대방, 포인트 환전, 포인트 충전, 캠페인 등록

    @Schema(description = "거래 시간")
    private LocalDateTime time;

    public static PointTransactionResponse from(PointTransaction p, String category) {
        return new PointTransactionResponse(
            p.getId(),
            p.getPoint().getId(),
            p.getPoint().getMemberId(),
            p.getAmount(),
            p.getPointStatus().getDescription(),
            category,
            p.getCounterparty(),
            p.getCreatedAt()
        );
    }
}
