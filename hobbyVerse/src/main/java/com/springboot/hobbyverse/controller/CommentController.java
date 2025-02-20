package com.springboot.hobbyverse.controller;

import java.security.Principal;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.springboot.hobbyverse.model.Comment;
import com.springboot.hobbyverse.repository.UserRepository;
import com.springboot.hobbyverse.service.CommentService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/comments")
@RequiredArgsConstructor
public class CommentController {
	private final CommentService commentService;
	private final UserRepository userRepository;

	//TODO 댓글 작성
	@PostMapping("/create")
	public ResponseEntity<?> createComment(@RequestParam Long boardId, @RequestParam(required = false) Long parentId, @RequestParam String userEmail, @RequestParam String userName, @RequestParam String content){
		Comment newComment = commentService.saveComment(boardId, parentId, content, userEmail, userName);
		
		System.out.println(content);
		return ResponseEntity.ok(newComment);
	}
	//TODO 댓글 수정
	
	//TODO 댓글 수정
	
	//TODO 댓글 삭제
	@PostMapping("/delete/{commentId}")
	public ResponseEntity<Comment> deleteComment(@PathVariable Long commentId){
		commentService.deleteComment(commentId);
		return ResponseEntity.ok().build();
	}
	
}
