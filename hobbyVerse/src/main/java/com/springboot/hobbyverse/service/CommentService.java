package com.springboot.hobbyverse.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.model.Board;
import com.springboot.hobbyverse.model.Comment;
import com.springboot.hobbyverse.repository.BoardRepository;
import com.springboot.hobbyverse.repository.CommentRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommentService {
	private final CommentRepository commentRepository;
	private final BoardRepository boardRepository;
	
	// 댓글 저장
	public Comment saveComment(Long boardId, Long parentId, String content, String userEmail, String userName) {
	    // 게시글 확인
	    Board board = boardRepository.findById(boardId)
	            .orElseThrow(() -> new IllegalArgumentException("게시글이 존재하지 않습니다."));
	    
	    Comment comment;
	    
	    // 대댓글인 경우
	    if (parentId != null) {
	        // 부모 댓글 확인
	        Comment parentComment = commentRepository.findById(parentId)
	                .orElseThrow(() -> new IllegalArgumentException("부모 댓글이 존재하지 않습니다."));
	        
	        // 대댓글 제한
	        if (parentComment.getDepth() >= 2) {
	            throw new IllegalArgumentException("더 이상 대댓글을 작성할 수 없습니다.");
	        }

	        // 대댓글 생성
	        comment = new Comment();
	        comment.setBoard(board);
	        comment.setParentId(parentComment.getId());
	        comment.setContent(content);
	        comment.setUserEmail(userEmail);
	        comment.setUserName(userName);
	        comment.setDepth(parentComment.getDepth() + 1);  // 부모 댓글보다 한 단계 깊게 설정
	        comment.setStatus(1);
	        
	        
	     // 최상위 댓글 ID를 groupId로 설정 (부모 댓글이 아니라 최상위 댓글의 ID)
	        Comment topLevelComment = parentComment;
	        while (topLevelComment.getParentId() != null) {
	            // 부모 댓글이 있으면 그 부모 댓글로 올라갑니다.
	            topLevelComment = commentRepository.findById(topLevelComment.getParentId())
	                    .orElseThrow(() -> new IllegalArgumentException("최상위 댓글을 찾을 수 없습니다."));
	        }
	        comment.setGroupId(topLevelComment.getId());  // 최상위 댓글의 ID를 groupId로 설정

	    } else { // 최상위 댓글인 경우
	        // 최상위 댓글 생성
	        comment = new Comment();
	        comment.setBoard(board);
	        comment.setContent(content);
	        comment.setUserEmail(userEmail);
	        comment.setUserName(userName);
	        comment.setDepth(0);  // 최상위 댓글은 depth 0
	        comment.setStatus(1);
	        comment.setGroupId(null);  // 자신의 ID를 groupId로 설정
	    }
	    
	    // 댓글 저장
	    return commentRepository.save(comment);
	}

    
    // 댓글 수정
    public Comment updateComment(Long id, String content) {
    	Comment comment = commentRepository.findById(id)
    			.orElseThrow(() -> new RuntimeException("댓글을 찾을 수 없습니다."));
    	comment.setContent(content);
    	return commentRepository.save(comment);
    }

    // 댓글 삭제
    public void deleteComment(Long commentId) {
        Comment comment = commentRepository.findById(commentId)
            .orElseThrow(() -> new IllegalArgumentException("댓글이 존재하지 않습니다."));
        comment.setStatus(0);  // 상태를 삭제로 변경
        commentRepository.save(comment);
    }
}
