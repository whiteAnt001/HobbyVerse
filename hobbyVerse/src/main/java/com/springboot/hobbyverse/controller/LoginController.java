package com.springboot.hobbyverse.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.dto.AddUserRequest;
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
	
	@GetMapping("/login")
	public ModelAndView getLogin(HttpServletRequest request){
		ModelAndView mav = new ModelAndView("login");
		request.setAttribute("user", new User());
		return mav;		
	}

	@PostMapping("/logout")
	public String logout(HttpSession session) {
	    session.invalidate(); // 세션 종료
	    return "redirect:/login"; // 🔹 올바른 리다이렉트 방식
	}

	
	//로그인을 시도했을 때 빈 칸이 있거나, 정보가 틀렸을 경우 처리 및 로그인 성공시 홈화면 매핑
	@PostMapping("/loginDo")
	public ModelAndView loginSuccess(@Valid User user,BindingResult br, String password, HttpSession session, AddUserRequest dto) {
		ModelAndView mav = new ModelAndView("login");
		if(br.hasErrors()) {
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		User loginUser = userRepository.findByEmail(user.getEmail());
		//사용자 정보 조회
		User luser = this.userService.getUser(loginUser);
		if(luser == null) { // 로그인 실패
			mav.addObject("FAIL", "YES");
		}else { //로그인 성공
			 // 암호화된 비밀번호 비교
	        boolean isPasswordMatch = userService.checkPassword(password, loginUser.getPassword());
	        if (isPasswordMatch) {
	        	session.setAttribute("loginUser", luser);
	        	mav.setViewName("redirect:/home"); // 🔹 로그인 성공 후 홈 이동
	        } else {
	            mav.addObject("FAIL", "YES");  // 비밀번호 불일치
	        }
		}
		return mav;
	}
}
