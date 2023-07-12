package com.example.demo;

import com.example.demo.repository.JdbcMemberRepository;
import com.example.demo.repository.JpaMemberRepository;
import com.example.demo.repository.MemberRepository;
import com.example.demo.service.MemberService;
import jakarta.persistence.EntityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;
import javax.swing.*;

@Configuration
public class SpringConfig {
/*  //Use this for MemoryMemberRepository or JdbcMemberRepository

    private final DataSource dataSource;
    public SpringConfig(DataSource dataSource)
    {
        this.dataSource = dataSource;
    }*/
    @Bean
    public MemberRepository memberRepository() {
        // return new MemoryMemberRepository(); // for Memory
        //return new JdbcMemberRepository(dataSource);//for JDBC
        return new JpaMemberRepository(em);
    }
    private EntityManager em;
    @Autowired
    public SpringConfig(EntityManager em)
    {
        this.em = em;
    }
    @Bean
    public MemberService memberService() {
        //return new MemberService(); //Memory only
        return new MemberService(memberRepository());
    }
}
