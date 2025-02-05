package com.springboot.hobbyverse.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.springboot.hobbyverse.dto.AddUserRequest;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.service.UserService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class UserViewController {
	@Autowired
	private UserService userService;

	@GetMapping("/login")
	public String getLogin(){
		return "login"; 			
	}
	
	@GetMapping("/signup")
	public String userEntry() {
		return "signup";
	}
	
	@PostMapping("/register")
    public String signup(AddUserRequest addUserRequest) {
        userService.save(addUserRequest); // 회원가입 메서드 호출
        return "signupResult"; //회원가입이 완려된 이후에 로그인 페이지로 이동
    }
}
