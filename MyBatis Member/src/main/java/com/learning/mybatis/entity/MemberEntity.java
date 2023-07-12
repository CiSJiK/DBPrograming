package com.learning.mybatis.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
@Getter @Setter
@Entity(name="member")
public class MemberEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column
    private String name;
}
