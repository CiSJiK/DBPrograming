package com.learning.mybatis.service;

import com.learning.mybatis.domain.Member;
import com.learning.mybatis.entity.MemberEntity;
import com.learning.mybatis.repository.MyBatisMemberRepository;

import java.util.List;
import java.util.Optional;


public class MemberService {
    private final MyBatisMemberRepository memberRepository;

    public MemberService(MyBatisMemberRepository memberRepository) {  //생성자 함수를 통한 DI 자동 주입
      this.memberRepository = memberRepository;
    }

    /**
     * 회원 가입
     */
    public Long join(MemberEntity member) {
        System.out.println();
        System.out.println("<<<< MemberService.join 회원가입 서비스 시작 >>>> ");
        System.out.println("member.id = " + member.getId());
        System.out.println("member.name = " + member.getName());
        //validateDuplicateMember(member);  //중복 회원 검증
        memberRepository.save(member);
        return member.getId();
    }

   private void validateDuplicateMember(MemberEntity member) {
        Optional<MemberEntity> result = memberRepository.findByName(member.getName());
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

        public Optional<MemberEntity> findOne(Long memberId) {
            return memberRepository.findById(memberId);
        }
}
