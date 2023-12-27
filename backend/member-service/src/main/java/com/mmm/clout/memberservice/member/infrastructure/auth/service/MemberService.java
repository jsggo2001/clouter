package com.mmm.clout.memberservice.member.infrastructure.auth.service;

import com.mmm.clout.memberservice.advertiser.domain.Advertiser;
import com.mmm.clout.memberservice.advertiser.domain.repository.AdvertiserRepository;
import com.mmm.clout.memberservice.clouter.domain.Clouter;
import com.mmm.clout.memberservice.clouter.domain.repository.ClouterRepository;
import com.mmm.clout.memberservice.common.Role;
import com.mmm.clout.memberservice.member.domain.Member;
import com.mmm.clout.memberservice.member.domain.exception.DuplicatePhoneNumberException;
import com.mmm.clout.memberservice.member.domain.repository.MemberRepository;
import com.mmm.clout.memberservice.member.infrastructure.auth.dto.MemberDTO;
import com.mmm.clout.memberservice.member.infrastructure.auth.dto.RequestMemberDto;
import com.mmm.clout.memberservice.member.infrastructure.auth.exception.NoMatchPasswordException;
import com.mmm.clout.memberservice.member.presentation.request.PwdUpdateRequst;
import com.mmm.clout.memberservice.member.presentation.response.AddCountContractResponse;
import com.mmm.clout.memberservice.star.domain.exception.NotFoundMemberException;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class MemberService {

    private final MemberRepository memberRepository;
    private final ClouterRepository clouterRepository;
    private final AdvertiserRepository advertiserRepository;
    private final BCryptPasswordEncoder encoder;
    private static int PLUS = 1;
    private static int MINUS = -1;

    public MemberDTO getUserById(Long id) {
        Member member = this.memberRepository.findById(id).orElseThrow(() -> new NoSuchElementException("존재하지 않는 유저 입니다."));
        MemberDTO dto = MemberDTO.builder()
            .id(member.getId())
            .role(member.getRole())
            .userId(member.getUserId())
            .build();
        return dto;
    }

    public Member getUserByUserId(String userId) {
        return memberRepository.findByUserId(userId).orElse(null);
    }

    @Transactional
    public Member updateUserPassword(PwdUpdateRequst request) {
        Member findMember = memberRepository.findById(request.getId()).orElseThrow(NotFoundMemberException::new);
        findMember.changePwd(encoder.encode(request.getPwd()));
        return findMember;
    }

    public List<MemberDTO> getUsers() {
        List<Member> members = memberRepository.findAll();
        return members.stream().map(user -> MemberDTO.builder()
            .id(user.getId())
            .userId(user.getUserId())
            .role(user.getRole())
            .build()).collect(Collectors.toList());
    }

    @Transactional
    public void passwordInit(String userId) {
        Member member = this.memberRepository.findByUserId(userId).orElseThrow(() -> new NoSuchElementException("존재하지 않는 유저입니다."));
        String password = makePassword();
        member.passwordUpdate(encoder.encode(password));
        // 새로 만든 비밀번호 발송 로직 필요
    }

    @Transactional
    public AddCountContractResponse addCountContract(List<Long> idList, Boolean addType) {
        List<Member> findMembers = idList.stream()
                .map(memberId -> memberRepository.findById(memberId).orElseThrow(() -> new NotFoundMemberException()))
                .collect(Collectors.toList());

        AddCountContractResponse response = new AddCountContractResponse();

        findMembers.stream()
                .forEach(member -> {
                    response.getMemberIdList().add(member.getId());
                    if (addType == true) {
                        response.getCountOfContracts().add(member.addCountOfContract(PLUS));
                    } else {
                        response.getCountOfContracts().add(member.addCountOfContract(MINUS));
                    }
                });
        return response;
    }

    private String makePassword() {
        String uuid = "";
        for (int i = 0; i < 5; i++) {
            uuid = UUID.randomUUID().toString().replaceAll("-", ""); // -를 제거해 주었다.
            uuid = uuid.substring(0, 10); //uuid를 앞에서부터 10자리 잘라줌.
        }
        return uuid;
    }

    public void checkPhonenumber(String phoneNumber, Role role) {
        if (role == Role.ADVERTISER) {
            Advertiser advertiser = advertiserRepository.findByCompanyInfo_ManagerPhoneNumber(phoneNumber).orElse(null);
            if (advertiser != null) throw new DuplicatePhoneNumberException();
        } else if (role == Role.CLOUTER) {
            Clouter clouter = clouterRepository.findByPhoneNumber(phoneNumber).orElse(null);
            if (clouter != null) throw new DuplicatePhoneNumberException();
        }
    }
}


