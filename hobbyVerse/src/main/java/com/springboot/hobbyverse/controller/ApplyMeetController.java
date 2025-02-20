package com.springboot.hobbyverse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.Cart;
import com.springboot.hobbyverse.model.MeetingApply;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.service.MeetingApplyService;
import com.springboot.hobbyverse.service.MeetingService;
import com.springboot.hobbyverse.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ApplyMeetController {
	@Autowired
	private Cart cart;
	@Autowired
	private UserService userService;
	@Autowired
	private MeetingService meetingService;
	@Autowired
	private MeetingApplyService meetingApplyService;
	
	
	//참가 신청
	@GetMapping("/applyMeeting")
	public ModelAndView apply(HttpSession session, Integer m_id) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser");
		if(user == null) {
			mav.setViewName("login");
			mav.addObject(new User());
			return mav;
		}
		//참가 신청 정보
		MeetingApply meetingApply = new MeetingApply();
		meetingApply.setId(user.getUserId());
		meetingApply.setEmail(user.getEmail());
		meetingApply.setM_id(m_id);
		meetingApply.setApply_date(java.sql.Date.valueOf(java.time.LocalDate.now()));
		
		//DB에 데이터 저장
		meetingApplyService.save(meetingApply);
		
		
		//참가신청 후 모임 상세 페이지
		mav.setViewName("applySuccess");
		mav.addObject("m_id", m_id);
		return mav;
	}

}

