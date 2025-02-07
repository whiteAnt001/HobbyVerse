package com.springboot.hobbyverse.controller;

import org.springframework.beans.factory.annotation.Autowired;
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
		ModelAndView mav = new ModelAndView("signup");
		return mav;
	}
	
	//회원가입 완료
	@PostMapping("/register")
    public ModelAndView signup(AddUserRequest addUserRequest) {
		ModelAndView mav = new ModelAndView("signupResult");
        userService.save(addUserRequest); // 회원가입 메서드 호출
        return mav; //회원가입이 완려된 이후에 로그인 페이지로 이동
    }
	
	@GetMapping("/myPage")
	public ModelAndView mypage(HttpSession session) {
		ModelAndView mav = new ModelAndView("myPage");
	    User user = (User) session.getAttribute("loginUser");

	    if (user == null) {
	        // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
	        mav.setViewName("redirect:/login");
	        return mav;
	    }
	    
	    mav.addObject("user", user);
	    return mav;
	}
	
	@PostMapping("/changePassword")
	public ModelAndView changePassword(@RequestParam String currentPassword, @RequestParam String newPassword, @RequestParam String confirmPassword, HttpSession session) {
	    ModelAndView mav = new ModelAndView("myPage");

	    User user = (User) session.getAttribute("loginUser");
	    // 비밀번호 일치 여부 확인
	    if (!newPassword.equals(confirmPassword)) {
	        mav.addObject("message", "새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
	        return mav;
	    }

	    // 비밀번호 변경 시도
	    boolean isChange = userService.changePassword(user.getUsername(), currentPassword, newPassword);

	    if (isChange) {
	        mav.addObject("message", "비밀번호가 성공적으로 변경되었습니다.");
	    } else {
	        mav.addObject("message", "현재 비밀번호가 올바르지 않습니다.");
	    }

	    // 업데이트된 사용자 정보
	    mav.addObject("user", user);
	    
	    return mav;
	}
}
