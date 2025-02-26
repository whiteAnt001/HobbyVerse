package com.springboot.hobbyverse.controller;

import java.lang.ProcessBuilder.Redirect;
import java.sql.Date;
import java.util.List;

import javax.swing.border.TitledBorder;

import org.eclipse.tags.shaded.org.apache.bcel.generic.NEW;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.beanvalidation.CustomValidatorBean;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.MeetingApply;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.repository.MeetingApplyRepsotory;
import com.springboot.hobbyverse.service.MeetingApplyService;
import com.springboot.hobbyverse.service.MeetingService;
import com.springboot.hobbyverse.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
@RequiredArgsConstructor
@Controller
public class ApplyMeetController {
	@Autowired
	private UserService userService;
	@Autowired
	private MeetingService meetingService;
	@Autowired
	private MeetingApplyService meetingApplyService;
	
	private final MeetingApplyRepsotory meetingApplyRepsotory;
	
	@PostMapping("/applyMeeting")
	public ModelAndView apply(Integer m_id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("forward:/success?m_id=" + m_id);
		return mav;
	}
	
	//참가 신청
	@RequestMapping("/success")
	public ModelAndView success(HttpSession session, Integer m_id, Long user_id) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser");
		if(user == null) {
			mav.setViewName("/login");
			mav.addObject(new User());
			return mav;
		}
		
		boolean existMeet = meetingApplyRepsotory.existsByIdAndMid(user.getUserId(), m_id);
		//true:가입됨, false:미가입
		
		//정보 저장
		MeetingApply meetingApply = new MeetingApply();
		meetingApply.setId(user.getUserId());
		meetingApply.setName(user.getName());
		meetingApply.setMid(m_id);
		meetingApply.setApply_date(java.sql.Date.valueOf(java.time.LocalDate.now()));
			
		//DB 저장
		if(! existMeet) {//존재하지 않는 모임일 경우
			meetingApplyRepsotory.save(meetingApply);	
			mav.addObject("alertSuccess","신청 완료했습니다." );
		} else {//이미 존재하는 모임일 경우
			List<MeetingApply> meetingApplies = this.meetingApplyService.joinedUser(m_id);
			List<MeetingApply> meetingList = this.meetingApplyService.meetingList(user_id);
 			
			mav.addObject("alertError", "이미 신청된 모임입니다. ");
			mav.setViewName("applySuccess");
			mav.addObject("meetingApplies", meetingApplies);
			mav.addObject("meetingLlist", meetingList);
			return mav;
		}
		List<MeetingApply> meetingApplies = this.meetingApplyService.joinedUser(m_id);
		List<MeetingApply> meetingList = this.meetingApplyService.meetingList(user_id);
			
		mav.setViewName("applySuccess");
		mav.addObject("meetingApplies", meetingApplies);
		mav.addObject("meetingList", meetingList);
		return mav;
	}


}

