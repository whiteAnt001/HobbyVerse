package com.springboot.hobbyverse.controller;

import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.Board;
import com.springboot.hobbyverse.model.Comment;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.repository.CommentRepository;
import com.springboot.hobbyverse.service.BoardService;
import com.springboot.hobbyverse.service.CommentService;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
@RequiredArgsConstructor
@Controller
public class BoardController {
    private final BoardService boardService;
    private final CommentService commentService;
    private final CommentRepository commentRepository;
    

    // ✅ 게시판 목록 페이지 (페이징 + 검색 추가)
    @GetMapping("/boards")
    public ModelAndView getBoardPage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(required = false) String keyword,
            HttpSession session) {

        int pageSize = 10;
        Pageable pageable = PageRequest.of(page - 1, pageSize, Sort.by(Sort.Direction.DESC, "regDate"));

        Page<Board> boardPage;
        if (keyword != null && !keyword.trim().isEmpty()) {
            boardPage = boardService.searchBoards(keyword, pageable);
        } else {
            boardPage = boardService.getAllBoards(pageable);
        }

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
        mav.addObject("keyword", keyword);

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
    	ModelAndView mav = new ModelAndView();
        User user = (User) session.getAttribute("loginUser");

        if (user != null) {
            board.setName(user.getName());  //  이름 저장
            board.setEmail(user.getEmail()); // 이메일 저장
            board.setUser(user);
        } else {
            mav.setViewName("redirect:/login");
            return mav;
        }
        
        boardService.saveBoard(board);
        mav.setViewName("redirect:/boards");
        mav.addObject("user", user);
        return mav;
    }


    // ✅ 게시글 상세 페이지 (조회 기능)
    @GetMapping("/boards/{seq}")
    public ModelAndView getBoardDetail(@PathVariable Long seq, HttpSession session, Board boardSeq) {
        Board board = boardService.getBoardById(seq);
        List<Comment> comments = commentRepository.findByBoardAndStatus(boardSeq, 1);
        ModelAndView mav = new ModelAndView("boardDetail");
        mav.addObject("board", board);
        mav.addObject("comments", comments);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        mav.addObject("formattedRegDate", board.getRegDate().format(formatter));

        User user = (User) session.getAttribute("loginUser");
        mav.addObject("user", user);

        return mav;
    }

    // ✅ 게시글 수정 처리 (제목, 내용만 수정 가능)
    @PostMapping("/boards/{seq}/update")
    public String updateBoard(@PathVariable Long seq, @RequestParam String subject, @RequestParam String content) {
        boardService.updateBoard(seq, subject, content);
        return "redirect:/boards"; // ✅ 수정 후 게시판 목록으로 이동
    }

    // ✅ 게시글 삭제 처리
    @Transactional
    @PostMapping("/boards/{seq}/delete")
    public ModelAndView deleteBoard(@PathVariable Long seq) {
        boardService.deleteBoard(seq);
        return new ModelAndView("redirect:/boards");
    }

    // ✅ 게시글 추천 기능 (AJAX 요청으로 처리)
    @PostMapping("/boards/{seq}/recommend")
    @ResponseBody
    public Map<String, Object> recommendBoard(@PathVariable Long seq, HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        Map<String, Object> response = new HashMap<>();

        if (user == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return response;
        }

        try {
            boardService.recommendPost(seq, user.getUserId());
            Board updatedBoard = boardService.getBoardById(seq);
            response.put("success", true);
            response.put("likes", updatedBoard.getLikes());
        } catch (RuntimeException e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }

        return response;
    }

    // ✅ [취소 버튼] 클릭 시 게시판 목록으로 이동
    @GetMapping("/boards/cancel")
    public ModelAndView cancelEditBoard() {
        return new ModelAndView("redirect:/boards");
    }

    // ✅ 관리자 게시글 수정 처리
    @PostMapping("/boards/{seq}/admin-update")
    public String adminUpdateBoard(@PathVariable("seq") Long seq,
                                   @RequestParam("subject") String subject,
                                   @RequestParam("content") String content,
                                   HttpSession session) {
        User user = (User) session.getAttribute("loginUser");

        if (user == null || !"ROLE_ADMIN".equals(user.getRole())) {
            return "redirect:/boards?error=Unauthorized";
        }

        Board board = boardService.getBoardById(seq);
        if (board == null) {
            return "redirect:/boards?error=NotFound";
        }

        boardService.updateBoard(seq, subject, content);

        return "redirect:/boards"; // ✅ 수정 후 무조건 boards 목록으로 이동
    }
}
   