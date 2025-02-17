package com.springboot.hobbyverse.repository;

import java.time.LocalDate;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.springboot.hobbyverse.model.LikedBoard;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.model.Board;

public interface LikedBoardRepository extends JpaRepository<LikedBoard, Long> {

    // ✅ 특정 사용자가 특정 게시글을 오늘 추천했는지 확인
    Optional<LikedBoard> findByUserAndBoardAndLikedDate(User user, Board board, LocalDate likedDate);
}
