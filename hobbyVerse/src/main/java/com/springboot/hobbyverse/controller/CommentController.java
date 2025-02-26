package com.springboot.hobbyverse.controller;

import java.text.spi.BreakIteratorProvider;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.springboot.hobbyverse.model.Board;
import com.springboot.hobbyverse.model.Comment;
import com.springboot.hobbyverse.repository.CommentRepository;
import com.springboot.hobbyverse.repository.UserRepository;
import com.springboot.hobbyverse.service.CommentService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/comments")
@RequiredArgsConstructor
public class CommentController {
	private final CommentService commentService;
	private final CommentRepository commentRepository;
	private final UserRepository userRepository;

	// 댓글 작성
	@PostMapping("/create")
	public ResponseEntity<?> createComment(@RequestParam Long boardId, @RequestParam(required = false) Long parentId, @RequestParam String userEmail, @RequestParam String userName, @RequestParam String content){
		Comment newComment = commentService.saveComment(boardId, parentId, content, userEmail, userName);
		return ResponseEntity.ok(newComment);
	}
	
	// 답글 작성
	@PostMapping("/create/{parentId}")
	public ResponseEntity<?> createReply(@PathVariable Long parentId, @RequestBody String content){
		Optional<Comment> parentCommentOpt = commentRepository.findById(parentId);
		if(parentCommentOpt.isEmpty()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("댓글을 찾을 수 없습니다.");
		}
		
		Comment parentComment = parentCommentOpt.get();
		Comment replyComment = new Comment();
		
		replyComment.setContent(content);
		replyComment.setParent(parentComment); //부모댓글 설정
		
		//대댓글 저장
		Board board = parentComment.getBoard(); //부모 댓글의 게시글 가져오기
		replyComment.setBoard(board); //대댓글을 부모 댓글의 게시판에 저장
		commentRepository.save(replyComment);
		
		return ResponseEntity.ok(replyComment);
		
	}
	// 댓글 수정
	@PutMapping("/updateComment/{commentId}")
	public ResponseEntity<?> updateComment(@PathVariable Long commentId, @RequestBody String newContent){
	    // 기존 댓글 조회
	    Optional<Comment> existingComment = commentRepository.findById(commentId);
	    if(existingComment.isEmpty()) {
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("댓글을 찾을 수 없습니다.");
	    }

	    Comment comment = existingComment.get();
	    comment.setContent(newContent); // 댓글 내용을 수정내용으로 변경
	    commentRepository.save(comment); //저장
		return ResponseEntity.ok(comment);
	}
	
	// 댓글 삭제
	@PostMapping("/delete/{commentId}")
	public ResponseEntity<Comment> deleteComment(@PathVariable Long commentId){
		commentService.deleteComment(commentId);
		return ResponseEntity.ok().build();
	}	
}
