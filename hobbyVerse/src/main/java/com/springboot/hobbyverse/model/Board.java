package com.springboot.hobbyverse.model;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Board {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long seq; // board_id 역할 (PK)

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

    // ✅ 이메일 필드 추가
    @Column(nullable = false)
    private String email = "unknown@example.com";  // 기본값 설정 (기존 데이터 처리)

    public Board() {
        this.regDate = LocalDateTime.now();
    }

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
            this.email = "unknown@example.com";  // ✅ 기존 데이터 문제 방지
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
	@Column(nullable = false)
	private int likes = 0;

	@Column(nullable = false)
	private String email = "unknown@example.com";

	// ✅ 댓글 리스트 추가 (게시글 삭제 시 댓글도 삭제됨)
	@OneToMany(mappedBy = "board", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<Comment> comments;

	public Board() {
		this.regDate = LocalDateTime.now();
	}

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

    public int getLikes() { return likes; }
    public void setLikes(int likes) { this.likes = likes; }

    public String getEmail() { return email; }  
    public void setEmail(String email) { this.email = email; }  
	public void incrementLikes() {
		this.likes++;
	}
}
