package com.springboot.hobbyverse.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springboot.hobbyverse.model.Inquiry;
import com.springboot.hobbyverse.service.InquiryService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/api/admin")  // ✅ 관리자 페이지 기본 경로
@RequiredArgsConstructor
public class AdminInquiryController {

    private final InquiryService inquiryService;

    /**
     * 
     */
    @GetMapping("")
    public String redirectToInquiries() {
        return "redirect:/api/admin/inquiries";
    }

    /**
     * ✅ 관리자 문의사항 목록 페이지
     */
    @GetMapping("/inquiries")
    public String showAdminInquiries(Model model) {
        List<Inquiry> inquiryList = inquiryService.getAllInquiriesForAdmin();
        model.addAttribute("inquiryList", inquiryList);
        return "inquiries_admin"; // ✅ 관리자용 JSP
    }

    /**
     * ✅ 관리자 문의사항 삭제 기능
     */
    @PostMapping("/inquiries/delete/{id}")
    public String deleteInquiry(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        inquiryService.deleteInquiry(id);
        redirectAttributes.addFlashAttribute("message", "문의사항이 삭제되었습니다.");
        return "redirect:/api/admin/inquiries";
    }

    /**
     * ✅ 관리자 문의사항 수정 폼 (관리자는 마스킹 X)
     */
    @GetMapping("/inquiries/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        Inquiry inquiry = inquiryService.getInquiryByIdForAdmin(id); // ✅ 수정된 부분
        
        if (inquiry == null) {
            return "redirect:/api/admin/inquiries"; // 문의사항이 없으면 목록 페이지로 이동
        }

        model.addAttribute("inquiry", inquiry);
        return "inquiry_admin_edit"; // ✅ 올바른 JSP 파일명
    }

    /**
     * ✅ 관리자 문의사항 수정 기능 (PUT 요청으로 변경)
     */
    @PostMapping("/inquiries/update/{id}")
    public String updateInquiry(
            @PathVariable Long id,
            @RequestParam String title,
            @RequestParam String content,
            RedirectAttributes redirectAttributes) {

        Inquiry inquiry = inquiryService.updateInquiry(id, title, content); // ✅ 수정 기능 호출

        if (inquiry == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "문의사항을 찾을 수 없습니다.");
            return "redirect:/api/admin/inquiries";
        }

        redirectAttributes.addFlashAttribute("message", "문의사항이 수정되었습니다.");
        return "redirect:/api/admin/inquiries";
    }

}
