package com.springboot.hobbyverse.service;

import java.time.LocalDate;
import java.util.HashMap;
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
import com.springboot.hobbyverse.repository.BoardRepository;
import com.springboot.hobbyverse.repository.CommentRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lombok.RequiredArgsConstructor;
@RequiredArgsConstructor
@Service
public class BoardService {
	 private final CommentRepository commentRepository;
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

    // ✅ 게시글 저장 (새 게시글 등록 및 수정)
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
        incrementViews(seq); // 조회수 증가
        return boardRepository.findById(seq).orElse(null);
    }

    // ✅ 조회수 증가 기능 추가
    @Transactional
    public void incrementViews(Long seq) {
        logger.info("게시글 조회수 증가: seq={}", seq);
        Board board = boardRepository.findById(seq).orElse(null);
        if (board != null) {
            board.setReadCount(board.getReadCount() + 1);
            boardRepository.save(board);
            logger.info("조회수 증가 완료: seq={}, 조회수={}", seq, board.getReadCount());
        } else {
            logger.warn("조회수 증가 실패: 게시글을 찾을 수 없음 seq={}", seq);
        }
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
            Board board = boardRepository.findById(seq).orElseThrow(() -> new RuntimeException("게시글을 찾을 수 없습니다."));
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
    public void deleteBoard(Long seq) {
        try {
            logger.info("게시글 삭제 시도: seq={}", seq);

            // ✅ 1. 먼저 해당 게시글의 모든 대댓글(답글) 삭제
            commentRepository.findAll().stream()
                    .filter(comment -> comment.getParentId() != null && comment.getBoard().getSeq().equals(seq))
                    .forEach(comment -> commentRepository.deleteByParentId(comment.getParentId()));
            logger.info("게시글의 대댓글 삭제 완료: seq={}", seq);

            // ✅ 2. 그 후 게시글의 댓글 삭제
            commentRepository.deleteByBoard_Seq(seq);
            logger.info("게시글의 댓글 삭제 완료: seq={}", seq);

            // ✅ 3. 게시글 삭제
            boardRepository.deleteBySeq(seq);
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

        Board board = boardRepository.findById(seq).orElseThrow(() -> new RuntimeException("게시글을 찾을 수 없습니다."));

        // 유저의 추천 기록 가져오기
        userRecommendations.putIfAbsent(userId, new HashMap<>());
        Map<Long, LocalDate> userRecommendationsForUser = userRecommendations.get(userId);

        LocalDate lastRecommendedDate = userRecommendationsForUser.get(seq);
        LocalDate today = LocalDate.now();

        if (lastRecommendedDate != null && lastRecommendedDate.isEqual(today)) {
            throw new RuntimeException("오늘은 이미 추천을 완료했습니다. 내일 다시 시도해주세요.");
        }

        // 추천 수 증가
        board.setLikes(board.getLikes() + 1);
        boardRepository.save(board);

        // 추천 기록 저장
        userRecommendationsForUser.put(seq, today);
        logger.info("게시글 추천 완료: seq={}, userId={}, 추천수={}", seq, userId, board.getLikes());
    }
}
