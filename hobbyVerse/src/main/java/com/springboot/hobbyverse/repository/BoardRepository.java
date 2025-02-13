package com.springboot.hobbyverse.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.springboot.hobbyverse.model.Board;

@Repository
public interface BoardRepository extends JpaRepository<Board, Long> {

    // ✅ 기존 게시글들의 SEQ 값을 +1 증가 (새로운 게시글이 항상 1번이 되도록)
    @Modifying
    @Transactional
    @Query("UPDATE Board b SET b.seq = b.seq + 1 WHERE b.seq IS NOT NULL")
    void incrementAllSeq();

    // ✅ 현재 가장 높은 SEQ 값을 찾는 쿼리
    @Query("SELECT MAX(b.seq) FROM Board b")
    Long findMaxSeq();

    // ✅ 제목에 특정 키워드가 포함된 게시글 검색 (페이징 지원)
    Page<Board> findBySubjectContaining(String keyword, Pageable pageable);
}
