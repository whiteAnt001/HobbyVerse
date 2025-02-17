package com.springboot.hobbyverse.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.dto.AddUserRequest;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class UserViewController {
	@Autowired
	private UserService userService;
	
	//회원가입
	@GetMapping("/signup")
	public ModelAndView userEntry() {
		return new ModelAndView("signup");
	}
	
	//회원가입 완료
	@PostMapping("/register")
    public ModelAndView signup(AddUserRequest addUserRequest) {
		ModelAndView mav = new ModelAndView("signup");			
		try {
			mav.setViewName("signupResult"); // 가입 성공시 회원가입 성공 창으로 이동
			userService.saveUser(addUserRequest); //폼 로그인 사용자 저장
		}catch (Exception e) {
			mav.addObject("errorMessage", e.getMessage()); //실패시 에러메세지 출력
		}
        return mav; //회원가입이 완려된 이후에 로그인 페이지로 이동
    }
}
