package com.springboot.hobbyverse.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.service.MeetingCancelService;
import com.springboot.hobbyverse.service.MeetingService;

import jakarta.servlet.http.HttpSession;

@Controller
public class CancelMeetController {
	@Autowired
	private MeetingCancelService meetingCancelService;
	@Autowired
	private MeetingService meetingService;

	@PostMapping("/cancelMeeting")
	public ModelAndView cancelMeet(Integer m_id) {
		ModelAndView mav = new ModelAndView();
		Meetup meetup = this.meetingService.getMeetingById(m_id);
		mav.addObject("meetup", meetup);
		mav.setViewName("forward:/cancel?m_id=" + m_id);
		return mav;
	}

	// 참가 취소
	@RequestMapping("/cancel")
	public ModelAndView cancel(HttpSession session, Integer m_id, Long user_id) {
		ModelAndView mav = new ModelAndView("detailGroup");
		User user = (User) session.getAttribute("loginUser");

		if (user == null) {
			mav.setViewName("/login");
			mav.addObject(new User());
			return mav;
		}

		meetingCancelService.MeetingCancel(m_id);

		mav.addObject("alertCancel", "신청이 취소되었습니다. ");

		mav.addObject("user", user);
		return mav;
	}

	@PostMapping("/outMeeting")
	public ModelAndView outMeeting(HttpSession session, Integer m_id, Integer id) {
		ModelAndView mav = new ModelAndView();
		Meetup meetup = meetingService.getMeetDetail(id);

		mav.addObject("meetup", meetup);
		mav.setViewName("forward:/out?m_id=" + m_id);
		return mav;
	}

	@RequestMapping("/out")
	public ModelAndView out(HttpSession session, Integer apply_id, @RequestParam Integer m_id) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser");

		this.meetingCancelService.outUser(apply_id);
		mav.addObject("user", user);

		mav.setViewName("redirect:/meetup/detail.html?id=" + m_id);
		return mav;
	}
	
	
	@PostMapping("/outMeetingCategory")
	public ModelAndView outMeetingCategory(HttpSession session, Integer m_id, Integer id) {
		ModelAndView mav = new ModelAndView();
		Meetup meetup = meetingService.getMeetDetail(id);

		mav.addObject("meetup", meetup);
		mav.setViewName("forward:/outCategory?m_id=" + m_id);
		return mav;
	}

	@RequestMapping("/outCategory")
	public ModelAndView outCategory(HttpSession session, Integer apply_id, @RequestParam Integer m_id) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser");

		this.meetingCancelService.outUser(apply_id);
		mav.addObject("user", user);

		mav.setViewName("redirect:/meetup/detail.html?id=" + m_id);
		return mav;
	}
}
