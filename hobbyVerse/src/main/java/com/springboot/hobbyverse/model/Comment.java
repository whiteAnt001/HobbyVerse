package com.springboot.hobbyverse.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
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
    
    @ManyToOne
    @JoinColumn(name = "user_id") // user_id라는 컬럼으로 Join
    private User user;
    

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
    private Integer status = 1;  // 기본값 1 설정
    
    @Column(name = "created_at_string")
    private String createdAtString;

    @Column(name = "updated_at_String", nullable = false)
    private String updatedAtString;

    @PrePersist
    public void prePersist() {
    	if(this.groupId == null) {
    		this.groupId = this.id;
    	}
    }
    
    public Comment addReply(Comment parentComment, String content, String userEmail, String userName) {
    	if(parentComment.getDepth() >= 2) {
    		throw new IllegalArgumentException("더 이상 대댓글을 작성할 수 없습니다.");
    	}
    	
    	Comment reply = new Comment();
    	reply.setBoard(parentComment.board);
    	reply.setParentId(parentComment.id);
    	reply.setContent(content);
    	reply.setDepth(parentComment.depth);
    	reply.setUserEmail(userEmail);
    	reply.setUserName(userName);
    	reply.setStatus(status);
    	reply.setCreatedAt(LocalDateTime.now());
    	
    	return reply;
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
