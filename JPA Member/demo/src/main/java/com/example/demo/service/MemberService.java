// 파일명 : /service/MemberService.java

package com.example.demo.service;

import com.example.demo.domain.Member;
import com.example.demo.repository.MemberRepository;
import jakarta.transaction.Transactional;

import java.util.List;
import java.util.Optional;
@Transactional
public class MemberService {
    private final MemberRepository memberRepository;

    public MemberService(MemberRepository memberRepository) {  //생성자 함수를 통한 DI 자동 주입
      this.memberRepository = memberRepository;
    }

    /**
     * 회원 가입
     */
    public Long join(Member member) {
        System.out.println();
        System.out.println("<<<< MemberService.join 회원가입 서비스 시작 >>>> ");
        System.out.println("member.id = " + member.getId());
        System.out.println("member.name = " + member.getName());
        validateDuplicateMember(member);  //중복 회원 검증
        memberRepository.save(member);
        return member.getId();
    }

   private void validateDuplicateMember(Member member) {
        Optional<Member> result = memberRepository.findByName(member.getName());
        result.ifPresent(m -> {
            throw new IllegalStateException("이미 존재하는 회원입니다.");
        });
            memberRepository.findByName(member.getName())
                   .ifPresent(m -> {
                        throw new IllegalStateException("이미 존재하는 회원입니다.");
                    });
    }

    /**
     * 전체 회원 조회
     */
        public List<Member> findMembers() {
            return memberRepository.findAll();
        }

        public Optional<Member> findOne(Long memberId) {
            return memberRepository.findById(memberId);
        }
}
