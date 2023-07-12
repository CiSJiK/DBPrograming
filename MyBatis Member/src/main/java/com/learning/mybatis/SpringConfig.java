package com.learning.mybatis;

import com.learning.mybatis.repository.MyBatisMemberRepository;
import com.learning.mybatis.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SpringConfig {
    private final MyBatisMemberRepository memberRepository;
    @Autowired
    public SpringConfig(MyBatisMemberRepository memberRepository)
    {
        this.memberRepository = memberRepository;
    }
    @Bean
    public MemberService memberService() {
        return new MemberService(memberRepository);
    }
}
