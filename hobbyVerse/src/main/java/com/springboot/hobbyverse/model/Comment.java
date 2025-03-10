package com.springboot.hobbyverse.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "comment")
@Getter
@Setter
public class Comment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "comment_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "board_id", nullable = false) 
    private Board board;

    @Column(name = "group_id", nullable = false)
    private Long groupId;

    @Column(name = "parent_id", insertable = false, updatable = false)
    private Long parentId; 

    @ManyToOne
    @JoinColumn(name = "parent_id")
    private Comment parent;

    @OneToMany(mappedBy = "parent", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Comment> replies = new ArrayList<>();

    @Column(name = "content", nullable = false, columnDefinition = "TEXT")
    private String content;

    @Column(nullable = false)
    private int depth = 0; // 기본값 0 (최상위 댓글)

    @Column(name = "created_at", updatable = false)
    @CreationTimestamp
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    @UpdateTimestamp
    private LocalDateTime updatedAt;

    @Column(name = "user_email", nullable = false)
    private String userEmail;

    @Column(name = "user_name", nullable = false)
    private String userName;

    @Column(name = "status", nullable = false)
    private Integer status = 1;

    // ✅ `createdAtString` 추가 (JSP에서 사용할 문자열 변환용)
    @Transient
    public String getCreatedAtString() {
        if (createdAt == null) return "";
        return createdAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    @PrePersist
    public void prePersist() {
        if (this.groupId == null) {
            this.groupId = this.id;
        }
    }
}
