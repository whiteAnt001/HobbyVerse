package com.springboot.hobbyverse.model;
import java.sql.Date;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.hibernate.annotations.CreationTimestamp;
import org.springframework.web.multipart.MultipartFile;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.persistence.Transient;
import lombok.Getter;
import lombok.Setter;

@Entity  // ✅ JPA 관리 엔티티 설정
@Table(name = "meetup")  // ✅ 실제 DB 테이블명과 일치하도록 지정
@Getter
@Setter
public class Meetup {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // ✅ 자동 증가 ID 설정 (필요 시)
    private Integer m_id;

    private String title;
    private String info;
    private Integer c_key;

    @Temporal(TemporalType.DATE)
    private Date m_date;  // 모임 날짜

    private Integer price;
    private String w_id;
    private String imagename;

    @CreationTimestamp
    private LocalDateTime w_date = LocalDateTime.now();  // 등록 날짜
    
    @Transient
    private String formattedW_date;

    @Column(name = "views", nullable = false, columnDefinition = "INT DEFAULT 0")
    private Integer views = 0;  // ✅ 기본값 0 설정


    private String category_name;

    @Transient  // ✅ DB에 저장되지 않음 (파일 업로드 용도)
    private MultipartFile file;

    private Integer recommend;
    
    @Column(name = "email", nullable = false)
    private String email;
    
    public String getformattedW_date() {
        if (w_date != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            return w_date.format(formatter);
        }
        return null;
    }
}
