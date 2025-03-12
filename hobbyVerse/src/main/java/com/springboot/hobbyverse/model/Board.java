package com.springboot.hobbyverse.model;

import java.time.LocalDateTime;
import jakarta.persistence.*;
import lombok.*;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Transient;
import jakarta.persistence.Version;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Board {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long seq;

    @ManyToOne
    @JoinColumn(name = "user_id") // Board 테이블에 user_id 컬럼 추가
    private User user; // 반드시 User 타입 필드명이 있어야 함
    @Column(nullable = false)
    private String subject;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String content;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private LocalDateTime regDate;

    private int readCount;

    @Version
    private Long version = 0L;

    @Transient
    private String formattedRegDate;

    @Column(nullable = false)
    private int likes = 0;

    @Column(nullable = false)
    private String email = "unknown@example.com";

    // ✅ **이미지 경로 추가**
    @Column(nullable = true, length = 500)
    private String imagePath;

    @PrePersist
    public void prePersist() {
        if (this.regDate == null) {
            this.regDate = LocalDateTime.now();
        }
        if (this.version == null) {
            this.version = 0L;
        }
        if (this.likes == 0) {
            this.likes = 0;
        }
        if (this.email == null) {
            this.email = "unknown@example.com";
        }
    }

    @PreUpdate
    public void preUpdate() {
        if (this.version == null) {
            this.version = 0L;
        }
    }

    public void incrementLikes() {
        this.likes++;
    }
}
