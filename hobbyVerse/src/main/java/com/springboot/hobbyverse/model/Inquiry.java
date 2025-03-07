package com.springboot.hobbyverse.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "inquiry")
public class Inquiry {
    @Transient
    private String maskedEmail;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;  // 내부 식별 ID (자동 증가)

    @Column(nullable = false)
    private Integer seq;  // 게시판 번호 (1부터 증가)

    @Column(nullable = false, length = 255)
    private String title;  // 문의 제목

    @Column(nullable = false, columnDefinition = "TEXT")
    private String content;  // 문의 내용

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();  // 작성 시간 (기본값: 현재시간)

    @Column(name = "user_email", length = 255)
    private String userEmail;  // ✅ 작성자 이메일을 그대로 사용

    @Column(name = "admin_reply", columnDefinition = "TEXT")
    private String adminReply;  // ✅ 운영자 답변 필드 추가

    // 🔹 DB에 저장되지 않는 변환된 날짜 필드
    @Transient
    private String formattedCreatedAt;

    public Inquiry(Integer seq, String title, String content, String userEmail) {
        this.seq = seq;
        this.title = title;
        this.content = content;
        this.userEmail = userEmail;
        this.createdAt = LocalDateTime.now();
    }

    public String getFormattedCreatedAt() {
        if (createdAt != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            return createdAt.format(formatter);
        }
        return null;
    }
}
