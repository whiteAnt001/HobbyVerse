package com.springboot.hobbyverse.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springboot.hobbyverse.model.Board;
import com.springboot.hobbyverse.repository.BoardRepository;

@Service
public class BoardService {

    private final BoardRepository boardRepository;

    public BoardService(BoardRepository boardRepository) {
        this.boardRepository = boardRepository;
    }

    // ✅ 모든 게시글 조회 (페이징 X)
    public List<Board> getAllBoards() {
        return boardRepository.findAll();
    }

    // ✅ 페이징 기능 추가 (최신순 정렬)
    public Page<Board> getBoardsWithPagination(Pageable pageable) {
        return boardRepository.findAll(pageable);
    }

    // ✅ 제목에 특정 키워드가 포함된 게시글 검색 (페이징 적용)
    public Page<Board> searchBoards(String keyword, Pageable pageable) {
        return boardRepository.findBySubjectContaining(keyword, pageable);
    }

    // ✅ 게시글 저장 (INSERT & UPDATE)
    @Transactional
    public Board saveBoard(Board board) {
        if (board.getSeq() != null) {  // 🔥 기존 SEQ 변경 방지
            Board existingBoard = boardRepository.findById(board.getSeq()).orElse(null);
            if (existingBoard != null) {
                existingBoard.setSubject(board.getSubject());
                existingBoard.setContent(board.getContent());
                return boardRepository.save(existingBoard);
            }
        }
        return boardRepository.save(board);
    }

    // ✅ 특정 게시글 조회
    public Board getBoardById(Long seq) {
        return boardRepository.findById(seq).orElse(null);
    }

    // ✅ 게시글 수정 기능 (제목 & 내용만 수정)
    @Transactional
    public void updateBoard(Long seq, String subject, String content) {
        Board board = boardRepository.findById(seq).orElse(null);
        if (board != null) {
            board.setSubject(subject); // 제목 수정
            board.setContent(content); // 내용 수정
            boardRepository.save(board); // 변경 내용 저장
        }
    }

    // ✅ 게시글 삭제 기능
    @Transactional
    public void deleteBoardById(Long seq) {
        boardRepository.deleteById(seq);
    }
}
