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

    // ✅ 홈 페이지 (게시판 목록 X → 홈 컨텐츠만 유지)
    @GetMapping("/home")
    public ModelAndView getHomePage(HttpSession session) {
        ModelAndView mav = new ModelAndView("index");

        // 로그인된 사용자 정보 추가 (로그인 유지)
        User user = (User) session.getAttribute("loginUser");
        mav.addObject("user", user);

        return mav;
    }

    // ✅ 게시판 페이지 (게시글 목록 조회 - 페이징 적용)
    @GetMapping("/boards")
    public ModelAndView getBoardPage(@RequestParam(defaultValue = "1") int page, HttpSession session) {
        int pageSize = 10;
        Pageable pageable = PageRequest.of(page - 1, pageSize, Sort.by(Sort.Direction.ASC, "seq"));
        Page<Board> boardPage = boardService.getBoardsWithPagination(pageable);

        // ✅ 날짜 변환 (yyyy-MM-dd HH:mm 형식으로)
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        List<Board> formattedBoards = boardPage.getContent().stream().map(board -> {
            board.setFormattedRegDate(board.getRegDate().format(formatter));
            return board;
        }).collect(Collectors.toList());

        ModelAndView mav = new ModelAndView("boards");
        mav.addObject("boardPage", boardPage);
        mav.addObject("formattedBoards", formattedBoards); // 변환된 날짜 포함
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

        // 로그인된 사용자 정보 추가
        User user = (User) session.getAttribute("loginUser");
        mav.addObject("user", user);

        return mav;
    }

    // ✅ 게시글 저장 처리 (로그인된 사용자 정보를 기반으로 작성자 자동 설정)
    @PostMapping("/boards/create")
    public ModelAndView createBoard(@ModelAttribute Board board, HttpSession session) {
        // 로그인된 사용자 정보 가져오기
        User user = (User) session.getAttribute("loginUser");

        if (user != null) {
            board.setName(user.getName());  // 로그인된 사용자의 이름을 작성자로 설정
        } else {
            return new ModelAndView("redirect:/login");  // 로그인되지 않은 경우 로그인 페이지로 이동
        }

        boardService.saveBoard(board);
        return new ModelAndView("redirect:/boards"); // 저장 후 게시판 목록으로 이동
    }

    // ✅ 게시글 상세 페이지
    @GetMapping("/boards/{seq}")
    public ModelAndView getBoardDetail(@PathVariable Long seq, HttpSession session) {
        Board board = boardService.getBoardById(seq);

        if (board == null) {
            return new ModelAndView("error/404"); // 게시글이 없으면 404 페이지로 이동
        }

        // ✅ 날짜 변환 (yyyy-MM-dd HH:mm 형식)
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        String formattedDate = board.getRegDate().format(formatter);

        ModelAndView mav = new ModelAndView("boardDetail"); // 상세 페이지 (boardDetail.jsp)
        mav.addObject("board", board);
        mav.addObject("formattedRegDate", formattedDate); // ✅ 변환된 날짜 추가

        // 로그인된 사용자 정보 추가 (로그인 유지)
        User user = (User) session.getAttribute("loginUser");
        mav.addObject("user", user);

        return mav;
    }
}
