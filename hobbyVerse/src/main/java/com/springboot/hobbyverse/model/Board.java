package com.springboot.hobbyverse.model;

import java.time.LocalDateTime;
import jakarta.persistence.*;

@Entity
public class Board {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long seq;
    
    private String subject;
    private String content;
    private String name;

    @Column(nullable = false)
    private LocalDateTime regDate;

    private int readCount;

    // ✅ 낙관적 락 해결을 위한 @Version 추가
    @Version
    private Long version;

    // ✅ 변환된 날짜를 저장할 임시 필드 (DB에 저장되지 않음)
    @Transient
    private String formattedRegDate;

    public Board() {
        this.regDate = LocalDateTime.now();
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
}
