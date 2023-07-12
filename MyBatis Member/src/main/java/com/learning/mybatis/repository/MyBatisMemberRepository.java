package com.learning.mybatis.repository;

import com.learning.mybatis.domain.Member;
import com.learning.mybatis.entity.MemberEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Optional;
@Mapper
public interface MyBatisMemberRepository {
    void save(MemberEntity memberEntity);
    Optional<MemberEntity> findById(Long id);
    Optional<MemberEntity> findByName(String name);
    List<Member> findAll();

    void update(MemberEntity memberEntity);
    void delete(MemberEntity memberEntity);
}
