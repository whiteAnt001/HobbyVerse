package com.springboot.hobbyverse.controller;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.springboot.hobbyverse.dto.CommentRequest;
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

    // 댓글 작성
    @PostMapping("/create")
    public ResponseEntity<?> createComment(@RequestBody CommentRequest commentRequest) {
        try {
            Comment newComment = commentService.saveComment(
                    commentRequest.getBoardId(),
                    commentRequest.getParentId(),
                    commentRequest.getContent(),
                    commentRequest.getUserEmail(),
                    commentRequest.getUserName()
            );
            return ResponseEntity.ok(Map.of("success", true, "comment", newComment));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("success", false, "message", e.getMessage()));
        }
        
        
    }

    // 댓글 수정
    @PutMapping("/updateComment/{commentId}")
    public ResponseEntity<?> updateComment(@PathVariable Long commentId, @RequestBody Map<String, String> request) {
        String newContent = request.get("content");

        Optional<Comment> existingComment = commentRepository.findById(commentId);
        if (existingComment.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("success", false, "message", "댓글을 찾을 수 없습니다."));
        }

        Comment comment = existingComment.get();
        comment.setContent(newContent);
        comment.setUpdatedAt(LocalDateTime.now());
        commentRepository.save(comment);

        return ResponseEntity.ok(Map.of("success", true, "comment", comment));
    }

    // 댓글 삭제
    @DeleteMapping("/delete/{commentId}")
    public ResponseEntity<?> deleteComment(@PathVariable Long commentId) {
        try {
            commentService.deleteComment(commentId);
            return ResponseEntity.ok(Map.of("success", true, "message", "댓글이 삭제되었습니다."));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("success", false, "message", "삭제 실패: " + e.getMessage()));
        }
    }
}
