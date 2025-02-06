package com.springboot.hobbyverse.controller;

import java.util.Optional;

import javax.security.auth.login.LoginException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.repsitory.UserRepository;
import com.springboot.hobbyverse.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class LoginController {
	@Autowired
	private UserService userService;
	@Autowired
	private UserRepository userRepository;
	
	//로그인 창으로 넘어가는 매핑
	@GetMapping("/login")
	public ModelAndView getLogin(HttpServletRequest request){
		ModelAndView mav = new ModelAndView("login");
		request.setAttribute("user", new User());
		return mav;		
	}
	
	//로그인을 시도했을 때 빈 칸이 있거나, 정보가 틀렸을 경우 처리 및 로그인 성공시 홈화면 매핑
	@PostMapping("/loginDo")
	public ModelAndView loginSuccess(@Valid User loginUser, BindingResult br, String email, String password, HttpSession session) {
		ModelAndView mav = new ModelAndView("login");
		if(br.hasErrors()) {
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		//사용자 정보 조회
		Optional<User> luser = this.userRepository.findByEmail(email);
		System.out.println(luser);
		if(loginUser == null) {
			mav.addObject("FAIL", "YES");
		}else {
	        try {
	            // 로그인 성공
	            User user = userService.login(email, password);
	            session.setAttribute("loginUser", user); // 로그인한 사용자 정보 세션에 저장
	            mav.setViewName("redirect:/home");
	        } catch (LoginException e) {
	            mav.addObject(e.getMessage()); // 예외처리 : 로그인 실패 시 메시지 전달
	        }
		}
		return mav;
	}

}
