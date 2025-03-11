package com.springboot.hobbyverse.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.springboot.hobbyverse.model.Board;
import com.springboot.hobbyverse.model.Comment;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {
	List<Comment> findByBoardAndStatus(Board board, Integer Status);
    void deleteByBoard_Seq(Long seq);
    void deleteByParentId(Long parentId);

	void deleteByUserEmail(String email);
}
