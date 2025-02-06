package com.springboot.hobbyverse.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class ViewController {
	@Autowired
	private UserService userService;
	
	@GetMapping("/home")
	public ModelAndView getHome(HttpSession session) {
		ModelAndView mav = new ModelAndView("index");
		User user = (User)session.getAttribute("loginUser");
		mav.addObject("user", user);
		return mav;
	}
}
