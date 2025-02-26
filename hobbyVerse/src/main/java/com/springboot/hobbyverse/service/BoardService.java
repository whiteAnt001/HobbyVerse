package com.springboot.hobbyverse.service;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.springboot.hobbyverse.model.Comment;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.repository.BoardRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.LockModeType;
import jakarta.persistence.PersistenceContext;
import lombok.RequiredArgsConstructor;
@RequiredArgsConstructor
@Service
public class BoardService {

    private static final Logger logger = LoggerFactory.getLogger(BoardService.class);
    private final BoardRepository boardRepository;
    @PersistenceContext
    private EntityManager entityManager;

    // ✅ 유저별 추천 내역 저장 (임시 저장, 실제 운영에서는 DB 사용 추천)
    private final Map<Long, Map<Long, LocalDate>> userRecommendations = new HashMap<>();


    // ✅ 최신순으로 게시글 조회 (번호 기준 내림차순 정렬)
    public Page<Board> getAllBoards(Pageable pageable) {
        return boardRepository.findAllByOrderBySeqDesc(pageable);
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
            board.setVersion(0L); // 초기 버전 설정
            Board savedBoard = boardRepository.save(board);
            logger.info("게시글 저장 성공: {}", savedBoard);
            return savedBoard;
        } catch (ObjectOptimisticLockingFailureException e) {
            logger.error("게시글 저장 중 충돌 발생", e);
            throw new RuntimeException("게시글 저장 중 충돌이 발생했습니다. 다시 시도해주세요.");
        }
    }

    // ✅ 특정 게시글 조회 (조회수 증가)
    @Transactional
    public Board getBoardById(Long seq) {
        logger.info("게시글 조회: seq={}", seq);

        Board board = entityManager.find(Board.class, seq, LockModeType.NONE);
        if (board == null) {
            throw new RuntimeException("게시글을 찾을 수 없습니다.");
        }

        board.setReadCount(board.getReadCount() + 1); // 조회수 증가
        boardRepository.save(board);
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

            Board board = entityManager.find(Board.class, seq, LockModeType.NONE);
            if (board == null) {
                throw new RuntimeException("게시글을 찾을 수 없습니다.");
            }

            board.setSubject(subject);
            board.setContent(content);
            boardRepository.save(board);

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

    // ✅ 추천 기능 (유저별 하루 1회만 가능)
    @Transactional
    public synchronized void recommendPost(Long seq, Long userId) {
        logger.info("게시글 추천 시도: seq={}, userId={}", seq, userId);

        Board board = entityManager.find(Board.class, seq, LockModeType.NONE);
        if (board == null) {
            throw new RuntimeException("게시글을 찾을 수 없습니다.");
        }

        // 유저의 추천 기록 가져오기
        Map<Long, LocalDate> userRecommendationsForUser = userRecommendations.getOrDefault(userId, new HashMap<>());
        LocalDate lastRecommendedDate = userRecommendationsForUser.get(seq);
        LocalDate today = LocalDate.now();

        if (lastRecommendedDate != null && lastRecommendedDate.isEqual(today)) {
            throw new RuntimeException("오늘은 이미 추천을 완료했습니다. 내일 다시 시도해주세요.");
        }

        // 추천 수 증가
        board.setLikes(board.getLikes() + 1);
        entityManager.merge(board); // 🔥 변경 사항 즉시 DB에 반영

        // 추천 기록 저장
        userRecommendationsForUser.put(seq, today);
        userRecommendations.put(userId, userRecommendationsForUser);

        logger.info("게시글 추천 완료: seq={}, userId={}, 추천수={}", seq, userId, board.getLikes());
    }
}
