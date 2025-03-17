package com.springboot.hobbyverse.repository;

import java.util.List;
import java.util.Optional;

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
	Optional<Board> findBySeq(Long seq);
	    List<Board> findByEmail(String email); // 특정 유저가 작성한 게시글 조회 (필요한 경우)

	    void deleteBySeq(Long seq);
    // ✅ 기존 모든 게시글의 SEQ 값을 +1 증가 (새로운 게시글이 1번이 되도록)
    @Modifying
    @Transactional
    @Query("UPDATE Board b SET b.seq = b.seq + 1 WHERE b.seq IS NOT NULL")
    void incrementAllSeq();

    // ✅ 현재 가장 높은 SEQ 값을 찾는 쿼리 (게시글이 없을 경우 NULL 반환 방지)
    @Query("SELECT COALESCE(MAX(b.seq), 0) FROM Board b")
    Long findMaxSeq();

    // ✅ 제목에 특정 키워드가 포함된 게시글 검색 (최신순 정렬 & 페이징 지원)
    Page<Board> findBySubjectContaining(String keyword, Pageable pageable);

    // ✅ 번호(SEQ) 기준 내림차순 정렬 (기존 방식 유지)
    Page<Board> findAllByOrderBySeqDesc(Pageable pageable);
	
	void deleteByEmail(String email);
	
	@Query(value = "SELECT * FROM board ORDER BY likes DESC LIMIT 4", nativeQuery = true)
	List<Board> getBoardList();
}
