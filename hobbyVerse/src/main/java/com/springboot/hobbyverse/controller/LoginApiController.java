package com.springboot.hobbyverse.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.repsitory.UserRepository;
import com.springboot.hobbyverse.service.UserService;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/user")
public class LoginApiController {
	@Autowired
	private UserService userService;
	
	//비밀번호 변경 API
	@PostMapping("/changePassword")
	public ResponseEntity<Map<String, String>> changePassword(@RequestParam String currentPassword, @RequestParam String newPassword, @RequestParam String confirmPassword, HttpSession session){
		Map<String, String> response = new HashMap<>();
		// 세션에서 로그인 정보 받아오기
		User user = (User)session.getAttribute("loginUser");
		
		//비밀번호가 일치하는지 확인
		if(!newPassword.equals("confirmPassword")) { //비밀번호가 일치하지 않으면 실행
			response.put("message", "새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			return ResponseEntity.badRequest().body(response);
		}
		
		boolean isChange = userService.changePassword(currentPassword, newPassword, newPassword);
		
		session.setAttribute("loginUser", user);
		if(isChange) { //비밀번호가 정상 변경 되었을 때 실행
			response.put("message", "비밀번호가 성공적으로 변경되었습니다.");
			return ResponseEntity.ok(response);
		} else { // 현재 비밀번호가 틀렸을 경우 실행
			response.put("message", "현재 비밀번호가 일치하지 않습니다.");
			return ResponseEntity.badRequest().body(response);
		}
	}
}
