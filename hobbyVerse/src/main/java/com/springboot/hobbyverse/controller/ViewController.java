package com.springboot.hobbyverse.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.service.UserService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class ViewController {
	@Autowired
	private UserService userService;
	
	@GetMapping("/hobbyverse")
	public String getHome(Model model) {
		
		return "home";
	}
	
	@PostMapping("/hobbyverse")
	public ModelAndView loginSuccess() {
		ModelAndView mav = new ModelAndView("index");
		User user = this.userService.getUser();
		mav.addObject("user", user);
		return mav;
	}
}
