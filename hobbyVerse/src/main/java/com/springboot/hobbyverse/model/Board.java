package com.springboot.hobbyverse.model;

import java.time.LocalDateTime;
import jakarta.persistence.*;

@Entity
public class Board {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long seq;

    @Column(nullable = false)
    private String subject;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String content;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private LocalDateTime regDate;

    private int readCount;

    // ✅ 낙관적 락(Optimistic Locking) 해결을 위한 @Version 기본값 설정
    @Version
    private Long version = 0L;

    // ✅ 변환된 날짜를 저장할 임시 필드 (DB에 저장되지 않음)
    @Transient
    private String formattedRegDate;

    public Board() {
        this.regDate = LocalDateTime.now();
    }

    // ✅ @PrePersist로 기본값 자동 설정
    @PrePersist
    public void prePersist() {
        if (this.regDate == null) {
            this.regDate = LocalDateTime.now();
        }
        if (this.version == null) {
            this.version = 0L;
        }
    }

    // ✅ @PreUpdate로 업데이트 시 기본값 유지
    @PreUpdate
    public void preUpdate() {
        if (this.version == null) {
            this.version = 0L;
        }
    }

    // Getter & Setter
    public Long getSeq() { return seq; }
    public void setSeq(Long seq) { this.seq = seq; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public LocalDateTime getRegDate() { return regDate; }
    public void setRegDate(LocalDateTime regDate) { this.regDate = regDate; }

    public int getReadCount() { return readCount; }
    public void setReadCount(int readCount) { this.readCount = readCount; }

    public String getFormattedRegDate() { return formattedRegDate; }
    public void setFormattedRegDate(String formattedRegDate) { this.formattedRegDate = formattedRegDate; }

    public Long getVersion() { return version; }
    public void setVersion(Long version) { this.version = version; }
}
