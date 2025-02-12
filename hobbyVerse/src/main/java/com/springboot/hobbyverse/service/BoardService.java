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

    // ✅ 게시글 삭제 기능
    @Transactional
    public void deleteBoardById(Long seq) {
        boardRepository.deleteById(seq);
    }
}
