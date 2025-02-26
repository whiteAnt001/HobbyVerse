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

import com.springboot.hobbyverse.model.Inquiry;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.service.InquiryService;

import jakarta.servlet.http.HttpSession;

@Controller
public class InquiryController {
    private final InquiryService inquiryService;

    public InquiryController(InquiryService inquiryService) {
        this.inquiryService = inquiryService;
    }

    // ✅ 문의사항 목록 페이지 (페이징 + 검색 추가)
    @GetMapping("/inquiries")
    public ModelAndView getInquiryPage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(required = false) String keyword,
            HttpSession session) {

        int pageSize = 10;
        Pageable pageable = PageRequest.of(page - 1, pageSize, Sort.by(Sort.Direction.DESC, "createdAt"));

        Page<Inquiry> inquiryPage;
        if (keyword != null && !keyword.trim().isEmpty()) {
            inquiryPage = inquiryService.searchInquiries(keyword, pageable);
        } else {
            inquiryPage = inquiryService.getAllInquiries(pageable);
        }

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        List<Inquiry> formattedInquiries = inquiryPage.getContent().stream().map(inquiry -> {
            inquiry.setFormattedCreatedAt(inquiry.getCreatedAt().format(formatter));
            return inquiry;
        }).collect(Collectors.toList());

        ModelAndView mav = new ModelAndView("inquiries");
        mav.addObject("inquiryPage", inquiryPage);
        mav.addObject("formattedInquiries", formattedInquiries);
        mav.addObject("currentPage", page);
        mav.addObject("totalPages", inquiryPage.getTotalPages());
        mav.addObject("keyword", keyword);

        // ✅ 로그인 유지
        User user = (User) session.getAttribute("loginUser");
        mav.addObject("user", user);

        return mav;
    }

    // ✅ 문의 작성 페이지 이동
    @GetMapping("/inquiries/write")
    public ModelAndView newInquiry(HttpSession session) {
        ModelAndView mav = new ModelAndView("inquiryWrite");
        mav.addObject("inquiry", new Inquiry());

        User user = (User) session.getAttribute("loginUser");
        mav.addObject("user", user);

        return mav;
    }

    // ✅ 문의 등록 처리
    @PostMapping("/inquiries/create")
    public ModelAndView createInquiry(@ModelAttribute Inquiry inquiry, HttpSession session) {
        User user = (User) session.getAttribute("loginUser");

        if (user != null) {
            inquiry.setUserEmail(user.getEmail()); // ✅ 이메일을 저장하고 그대로 사용
        } else {
            return new ModelAndView("redirect:/login");
        }

        inquiryService.saveInquiry(inquiry);
        return new ModelAndView("redirect:/inquiries");
    }

    // ✅ 문의 상세 페이지
    @GetMapping("/inquiries/{id}")
    public ModelAndView getInquiryDetail(@PathVariable Long id, HttpSession session) {
    	Inquiry inquiry = inquiryService.getInquiryById(id, false); // ✅ 관리자 페이지에서는 마스킹 제거

        ModelAndView mav = new ModelAndView("inquiryDetail");
        mav.addObject("inquiry", inquiry);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        mav.addObject("formattedCreatedAt", inquiry.getCreatedAt().format(formatter));

        // ✅ 로그인 유지
        User user = (User) session.getAttribute("loginUser");
        mav.addObject("user", user);

        return mav;
    }
}
