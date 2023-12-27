package com.mmm.clout.pointservice.point.presentation;

import com.mmm.clout.pointservice.common.docs.PointControllerDocs;
import com.mmm.clout.pointservice.point.presentation.request.CreatePointRequest;
import com.mmm.clout.pointservice.point.application.facade.PointFacade;
import com.mmm.clout.pointservice.point.domain.Point;
import com.mmm.clout.pointservice.point.domain.PointTransaction;
import com.mmm.clout.pointservice.point.presentation.request.ChargePointRequest;
import com.mmm.clout.pointservice.point.presentation.request.ReducePointRequest;
import com.mmm.clout.pointservice.point.presentation.request.WithdrawPointRequest;
import com.mmm.clout.pointservice.point.presentation.request.AddPointRequest;
import com.mmm.clout.pointservice.point.presentation.response.AddPointResponse;
import com.mmm.clout.pointservice.point.presentation.response.ChargePointResponse;
import com.mmm.clout.pointservice.point.presentation.response.CreatePointResponse;
import com.mmm.clout.pointservice.point.presentation.response.CustomPageResponse;
import com.mmm.clout.pointservice.point.presentation.response.GetMemberTotalPointResponse;
import com.mmm.clout.pointservice.point.presentation.response.PointTransactionResponse;
import com.mmm.clout.pointservice.point.presentation.response.ReducePointResponse;
import java.util.stream.Collectors;
import javax.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1/points")
@RequiredArgsConstructor
public class PointController implements PointControllerDocs {

    private final PointFacade pointFacade;

    /**
     * 충전
     */
    @PostMapping("/charge")
    public ResponseEntity<ChargePointResponse> charge(
        @Valid @RequestBody ChargePointRequest request
    ) {
        ChargePointResponse result = ChargePointResponse.from(
            pointFacade.charge(request.toCommand())
        );
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    /**
     * 포인트 차감/사용 (-)
     */
    @PostMapping("/reduce")
    public ResponseEntity<ReducePointResponse> reduce(
        @Valid @RequestBody ReducePointRequest request
    ) {
        ReducePointResponse result = ReducePointResponse.from(pointFacade.reduce(request.toCommand()));
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    /**
     * 포인트 지급 (+)
     */
    @PostMapping("/add")
    public ResponseEntity<AddPointResponse> add(
        @Valid @RequestBody AddPointRequest request
    ) {
        AddPointResponse result = AddPointResponse.from(pointFacade.add(request.toCommand()));
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    /**
     * 출금
     */
    @PostMapping("/withdrawal")
    public ResponseEntity<Void> withdraw(
        @Valid @RequestBody WithdrawPointRequest request
    ) {
        pointFacade.withdrawal(request.toCommand());
        return new ResponseEntity<>(HttpStatus.OK);
    }

    /**
     * 유저 포인트 잔액 조회
     */
    @GetMapping
    public ResponseEntity<GetMemberTotalPointResponse> getMemberPoint(
        @RequestParam Long memberId
    ) {
        GetMemberTotalPointResponse result = GetMemberTotalPointResponse.from(
            pointFacade.getMemberPoint(memberId));
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    /**
     * 거래내역 조회
     */
    @GetMapping("/transactions")
    public ResponseEntity<CustomPageResponse<PointTransactionResponse>> getTransactionListByType(
        @RequestParam Long memberId,
        @RequestParam String category,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int size
    ) {

        Page<PointTransaction> transactions = pointFacade.getTransactionListByCategory(memberId, category, PageRequest.of(page, size));

        CustomPageResponse<PointTransactionResponse> result = new CustomPageResponse<>(
            transactions.stream()
                .map(transaction -> PointTransactionResponse.from(transaction, category))
                .collect(Collectors.toList()),
            transactions.getNumber(),
            transactions.getSize(),
            transactions.getTotalPages(),
            transactions.getTotalElements()
        );

        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    /**
     * 포인트 초기화 (회원가입시 생성)
     */
    @PostMapping
    public ResponseEntity<CreatePointResponse> create(
        @Valid @RequestBody CreatePointRequest request
    ) {
        CreatePointResponse result = CreatePointResponse.from(pointFacade.create(request.getMemberId()));
        return new ResponseEntity<>(result, HttpStatus.CREATED);
    }
}
