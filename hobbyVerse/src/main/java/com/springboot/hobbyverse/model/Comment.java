package com.springboot.hobbyverse.model;

import java.time.LocalDateTime;
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
	@JoinColumn(name = "board_id", nullable = false) // board(SEQ) 참조
	private Board board;
	
    @Column(name = "group_id", nullable = false)
    private Long groupId;
    
    @ManyToOne
    @JoinColumn(name = "parent_id")
    private Comment parent; // 대댓글을 위한 부모 댓글
	
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
    private Integer status; // 0: 삭제됨, 1: 등록됨
    
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
    	reply.setParent(parentComment);
    	reply.setContent(content);
    	reply.setDepth(parentComment.depth);
    	reply.setUserEmail(userEmail);
    	reply.setUserName(userName);
    	reply.setStatus(status);
    	
    	return reply;
    }
}
