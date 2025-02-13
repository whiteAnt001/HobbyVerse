package com.springboot.hobbyverse.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.orm.ObjectOptimisticLockingFailureException;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Retryable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import com.springboot.hobbyverse.model.Board;
import com.springboot.hobbyverse.repository.BoardRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.LockModeType;
import jakarta.persistence.PersistenceContext;

@Service
public class BoardService {

    private static final Logger logger = LoggerFactory.getLogger(BoardService.class);
    private final BoardRepository boardRepository;

    @PersistenceContext
    private EntityManager entityManager;

    public BoardService(BoardRepository boardRepository) {
        this.boardRepository = boardRepository;
    }

    // ✅ 최신순으로 게시글 조회 (번호 기준 내림차순 정렬)
    public Page<Board> getAllBoards(Pageable pageable) {
        return boardRepository.findAllByOrderBySeqDesc(pageable); // 🔥 SEQ 기준 내림차순 정렬 적용
    }

    // ✅ 특정 키워드 포함된 게시글 검색 (SEQ 기준 최신순)
    public Page<Board> searchBoards(String keyword, Pageable pageable) {
        return boardRepository.findBySubjectContaining(keyword, pageable);
    }

    // ✅ 게시글 저장
    @Retryable(
        value = ObjectOptimisticLockingFailureException.class, 
        maxAttempts = 3, 
        backoff = @Backoff(delay = 500)
    )
    @Transactional
    public Board saveBoard(Board board) {
        try {
            logger.info("게시글 저장 시도: {}", board);

            // ✅ SEQ 자동 증가 설정 유지
            board.setVersion(0L); // 초기 버전 설정

            Board savedBoard = boardRepository.save(board); // JPA 자동 증가 사용
            logger.info("게시글 저장 성공: {}", savedBoard);

            return savedBoard;
        } catch (ObjectOptimisticLockingFailureException e) {
            logger.error("게시글 저장 중 충돌 발생", e);
            throw new RuntimeException("게시글 저장 중 충돌이 발생했습니다. 다시 시도해주세요.");
        }
    }

    // ✅ 특정 게시글 조회 (비관적 락 제거)
    @Transactional
    public Board getBoardById(Long seq) {
        logger.info("게시글 조회: seq={}", seq);

        Board board = entityManager.find(Board.class, seq, LockModeType.NONE); // 🔥 비관적 락 제거
        if (board == null) {
            throw new RuntimeException("게시글을 찾을 수 없습니다.");
        }

        board.setReadCount(board.getReadCount() + 1); // 조회수 증가
        boardRepository.save(board); // 🔥 변경 사항 저장

        return board;
    }

    // ✅ 게시글 수정 (제목 & 내용)
    @Retryable(
        value = ObjectOptimisticLockingFailureException.class, 
        maxAttempts = 3, 
        backoff = @Backoff(delay = 500)
    )
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void updateBoard(Long seq, String subject, String content) {
        try {
            logger.info("게시글 수정 시도: seq={}, subject={}, content={}", seq, subject, content);

            Board board = entityManager.find(Board.class, seq, LockModeType.NONE); // 🔥 락 제거
            if (board == null) {
                throw new RuntimeException("게시글을 찾을 수 없습니다.");
            }

            board.setSubject(subject);
            board.setContent(content);

            boardRepository.save(board); // 🔥 변경 사항 저장
            logger.info("게시글 수정 완료: {}", board);
        } catch (ObjectOptimisticLockingFailureException e) {
            logger.error("게시글 수정 중 충돌 발생", e);
            throw new RuntimeException("게시글 수정 중 충돌이 발생했습니다. 다시 시도해주세요.");
        }
    }

    // ✅ 게시글 삭제
    @Retryable(
        value = ObjectOptimisticLockingFailureException.class, 
        maxAttempts = 3, 
        backoff = @Backoff(delay = 500)
    )
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void deleteBoardById(Long seq) {
        try {
            logger.info("게시글 삭제 시도: seq={}", seq);

            Board board = entityManager.find(Board.class, seq, LockModeType.NONE);
            if (board == null) {
                throw new RuntimeException("게시글을 찾을 수 없습니다.");
            }

            boardRepository.deleteById(seq);
            logger.info("게시글 삭제 완료: seq={}", seq);
        } catch (ObjectOptimisticLockingFailureException e) {
            logger.error("게시글 삭제 중 충돌 발생", e);
            throw new RuntimeException("게시글 삭제 중 충돌이 발생했습니다. 다시 시도해주세요.");
        }
    }
}
