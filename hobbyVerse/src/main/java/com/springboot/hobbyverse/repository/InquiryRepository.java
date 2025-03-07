package com.springboot.hobbyverse.repository;

import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.springboot.hobbyverse.model.Inquiry;

@Repository
public interface InquiryRepository extends JpaRepository<Inquiry, Long> {
    
    Optional<Inquiry> findById(Long id);  // 특정 문의사항 조회

    List<Inquiry> findByUserEmail(String userEmail);  // 특정 유저가 작성한 문의사항 조회

    void deleteById(Long id);  // 특정 문의사항 삭제

    // ✅ 현재 가장 높은 SEQ 값을 찾는 쿼리 (문의사항이 없을 경우 NULL 방지)
    @Query("SELECT COALESCE(MAX(i.seq), 0) FROM Inquiry i")
    Integer findMaxSeq();

    // ✅ 제목 또는 내용에 특정 키워드가 포함된 문의사항 검색 (페이징 지원)
    Page<Inquiry> findByTitleContainingIgnoreCaseOrContentContainingIgnoreCase(String title, String content, Pageable pageable);

    // ✅ 번호(SEQ) 기준 내림차순 정렬 (최신순 정렬)
    Page<Inquiry> findAllByOrderBySeqDesc(Pageable pageable);
    List<Inquiry> findAllByOrderBySeqDesc(); // 관리자 전용 목록 (페이징 없음)

    @Modifying
    @Transactional
    @Query("UPDATE Inquiry i SET i.adminReply = :reply WHERE i.id = :id")
    void updateAdminReply(@Param("id") Long id, @Param("reply") String reply);
}
