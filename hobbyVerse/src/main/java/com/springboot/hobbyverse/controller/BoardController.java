package com.springboot.hobbyverse.controller;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.Board;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.service.BoardService;

import jakarta.servlet.http.HttpSession;

@Controller
public class BoardController {
    private final BoardService boardService;

    public BoardController(BoardService boardService) {
        this.boardService = boardService;
    }

    // ✅ 홈 페이지
    @GetMapping("/home")
    public ModelAndView getHomePage(HttpSession session) {
        ModelAndView mav = new ModelAndView("index");
        User user = (User) session.getAttribute("loginUser");
        mav.addObject("user", user);
        return mav;
    }

    // ✅ 게시판 목록 페이지 (페이징)
    @GetMapping("/boards")
    public ModelAndView getBoardPage(@RequestParam(defaultValue = "1") int page, HttpSession session) {
        int pageSize = 10;
        Pageable pageable = PageRequest.of(page - 1, pageSize, Sort.by(Sort.Direction.ASC, "seq"));
        Page<Board> boardPage = boardService.getBoardsWithPagination(pageable);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        List<Board> formattedBoards = boardPage.getContent().stream().map(board -> {
            board.setFormattedRegDate(board.getRegDate().format(formatter));
            return board;
        }).collect(Collectors.toList());

        ModelAndView mav = new ModelAndView("boards");
        mav.addObject("boardPage", boardPage);
        mav.addObject("formattedBoards", formattedBoards);
        mav.addObject("currentPage", page);
        mav.addObject("totalPages", boardPage.getTotalPages());

        User user = (User) session.getAttribute("loginUser");
        mav.addObject("user", user);

        return mav;
    }

    // ✅ 게시글 작성 페이지 이동
    @GetMapping("/boards/new")
    public ModelAndView newBoard(HttpSession session) {
        ModelAndView mav = new ModelAndView("new");
        mav.addObject("board", new Board());

        User user = (User) session.getAttribute("loginUser");
        mav.addObject("user", user);

        return mav;
    }

    // ✅ 게시글 저장 처리
    @PostMapping("/boards/create")
    public ModelAndView createBoard(@ModelAttribute Board board, HttpSession session) {
        User user = (User) session.getAttribute("loginUser");

        if (user != null) {
            board.setName(user.getName());
        } else {
            return new ModelAndView("redirect:/login");
        }

        boardService.saveBoard(board);
        return new ModelAndView("redirect:/boards");
    }

    // ✅ 게시글 상세 페이지 (수정 및 삭제 버튼 추가)
    @GetMapping("/boards/{seq}")
    public ModelAndView getBoardDetail(@PathVariable Long seq, HttpSession session) {
        Board board = boardService.getBoardById(seq);

        ModelAndView mav = new ModelAndView("boardDetail");
        mav.addObject("board", board);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        mav.addObject("formattedRegDate", board.getRegDate().format(formatter));

        User user = (User) session.getAttribute("loginUser");
        mav.addObject("user", user);

        return mav;
    }

    // ✅ 게시글 수정 페이지 (작성자와 작성일은 수정 불가)
    @GetMapping("/boards/{seq}/edit")
    public ModelAndView editBoard(@PathVariable Long seq, HttpSession session) {
        Board board = boardService.getBoardById(seq);

        ModelAndView mav = new ModelAndView("editBoard");
        mav.addObject("board", board);

        User user = (User) session.getAttribute("loginUser");
        mav.addObject("user", user);

        return mav;
    }

 // ✅ 게시글 수정 처리 (제목, 내용만 수정 가능)
    @PostMapping("/boards/{seq}/update")
    public ModelAndView updateBoard(@PathVariable Long seq, @RequestParam String subject, @RequestParam String content) {
        boardService.updateBoard(seq, subject, content);
        return new ModelAndView("redirect:/boards"); // ✅ 수정 후 게시판 목록으로 이동
    }


    // ✅ 게시글 삭제 처리
    @PostMapping("/boards/{seq}/delete")
    public ModelAndView deleteBoard(@PathVariable Long seq) {
        boardService.deleteBoardById(seq);
        return new ModelAndView("redirect:/boards");
    }

    // ✅ [취소 버튼] 클릭 시 게시판 목록으로 이동
    @GetMapping("/boards/cancel")
    public ModelAndView cancelEditBoard() {
        return new ModelAndView("redirect:/boards");
    }
}
