package com.springboot.hobbyverse.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.sym.Name;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ApplyController {
	@Autowired
	private UserService userService;

	
	//신청하기
	public ModelAndView apply(Integer id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser");
		if(user == null) { 	//로그인이 안돼있을 경우 -> 로그인 페이지
			mav.setViewName("login");
		} else { //로그인 되어있을 경우 -> 신청완료 페이지
			User userInfo = this.userService.getUserInfo(id);
			mav.addObject("userInfo", userInfo);
			mav.setViewName("DetailGroupResult");
		}
		return mav;
	}

}
