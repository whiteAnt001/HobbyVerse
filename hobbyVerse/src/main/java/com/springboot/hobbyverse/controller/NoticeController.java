package com.springboot.hobbyverse.controller;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.dto.NoticeRequest;
import com.springboot.hobbyverse.model.Notice;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.repository.NoticeRepository;
import com.springboot.hobbyverse.service.NoticeService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/notices")
public class NoticeController {
	private final NoticeService noticeService;
	private final NoticeRepository noticeRepository;
	
	//공지사항 목록
	@GetMapping()
	private ModelAndView getNoticeList(HttpSession session) {
		User user = (User)session.getAttribute("loginUser");
		ModelAndView mav = new ModelAndView("notices");
		List<Notice> noticeList = this.noticeRepository.findAll();
		mav.addObject("notice", noticeList);
		mav.addObject("user", user);
		return mav;
	}
	
	//공지사항 작성 폼
	@GetMapping("/createForm")
	public ModelAndView crateNotice(Notice notice, HttpSession session) {
		ModelAndView mav = new ModelAndView("createNotice");
		User user = (User)session.getAttribute("loginUser");
		mav.addObject(new Notice());
		mav.addObject("user", user);
		return mav;
	}
	
	//공지사항 등록
	@PostMapping("/create")
	public ResponseEntity<?> createNotice(@RequestBody NoticeRequest noticeRequest){
		try {
		Notice newNotice = noticeService.saveNotice(
				noticeRequest.getTitle(),
				noticeRequest.getContent(),
				noticeRequest.getEmail()
				);
		return ResponseEntity.ok(Map.of("success", true, "notice", newNotice));
		} catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("success", false, "message", e.getMessage()));
        }
	}
	
	//공지사항 상세
	@GetMapping("/{id}")
	public ModelAndView noticeDetail(@PathVariable Long id, HttpSession session) {
		ModelAndView mav = new ModelAndView("noticeDetail");
		User user = (User)session.getAttribute("loginUser");
		Optional<Notice> notice = this.noticeRepository.findById(id);
        if (notice.isPresent()) {
            mav.addObject("notice", notice.get());
        } else {
            mav.addObject("error", "공지사항을 찾을 수 없습니다.");
        }
		mav.addObject("user", user);
		return mav;
	}
	
	@DeleteMapping("/{id}")
	public void deleteNodice(@PathVariable Long id) {
		noticeService.deleteNotice(id);
	}
	
}
