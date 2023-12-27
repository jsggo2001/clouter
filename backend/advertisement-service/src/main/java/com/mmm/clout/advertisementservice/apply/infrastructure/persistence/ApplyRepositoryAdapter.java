package com.mmm.clout.advertisementservice.apply.infrastructure.persistence;

import static com.mmm.clout.advertisementservice.apply.domain.QApply.apply;

import com.mmm.clout.advertisementservice.advertisements.domain.Campaign;
import com.mmm.clout.advertisementservice.apply.domain.Apply;
import com.mmm.clout.advertisementservice.apply.domain.Apply.ApplyStatus;
import com.mmm.clout.advertisementservice.apply.domain.repository.ApplyRepository;
import com.mmm.clout.advertisementservice.apply.infrastructure.persistence.jpa.JpaApplyRepository;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class ApplyRepositoryAdapter implements ApplyRepository {

    private final JpaApplyRepository jpaApplyRepository;
    private final JPAQueryFactory queryFactory;

    @Override
    public Apply save(Apply apply) {
        return jpaApplyRepository.save(apply);
    }

    @Override
    public Optional<Apply> findById(Long applyId) {
        return jpaApplyRepository.findById(applyId);
    }

    @Override
    public boolean checkApplyExists(Campaign campaign, Long clouterId) {
        return jpaApplyRepository.existsByCampaignAndApplicant_ApplicantId(campaign, clouterId);
    }

    // 페이징 처리를 위한 데이터 조회 쿼리
    @Override
    public List<Apply> getAllByStatus(Pageable pageable, Long applicantId, ApplyStatus applyStatus) {
        // QueryDSL 쿼리 작성
        return queryFactory.selectFrom(apply)
            .where(
                applicantEq(applicantId),
                applyStatusEq(applyStatus)
            )
            .offset(pageable.getOffset())
            .limit(pageable.getPageSize())
            .fetch();
    }

    private static BooleanExpression applyStatusEq(ApplyStatus applyStatus) {
        return apply.applyStatus.eq(applyStatus);
    }

    private static BooleanExpression applicantEq(Long applicantId) {
        return apply.applicant.applicantId.eq(applicantId);
    }

    // 전체 데이터 수 계산을 위한 쿼리
    @Override
    public JPAQuery<Apply> countByStatus(Long applicantId, ApplyStatus applyStatus) {
        // QueryDSL count 쿼리 작성
        return queryFactory.select(apply)
            .from(apply)
            .where(
                applicantEq(applicantId),
                applyStatusEq(applyStatus)
            );
    }

    @Override
    public JPAQuery<Apply> countByAdvertisement(Long advertisementId) {
        return queryFactory.selectFrom(apply)
            .where(campaignIdEq(advertisementId)
                .and(apply.applyStatus.ne(ApplyStatus.CANCEL)));
    }



    private static BooleanExpression campaignIdEq(Long advertisementId) {
        return apply.campaign.id.eq(advertisementId);
    }


    @Override
    public List<Apply> findApplicantList(Long advertisementId, Pageable pageable) {
        return jpaApplyRepository.findByCampaignId(advertisementId, pageable);
    }

    @Override
    public List<Apply> findByCampaign(Campaign campaign) {
        return jpaApplyRepository.findByCampaign(campaign);
    }

    @Override
    public Optional<Apply> findByCampaign_IdAndApplicant_ApplicantId(Long advertisementId, Long clouterId) {
        return jpaApplyRepository.findByCampaign_IdAndApplicant_ApplicantId(advertisementId, clouterId);
    }
}
