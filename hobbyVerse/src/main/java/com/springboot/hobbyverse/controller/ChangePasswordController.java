package com.springboot.hobbyverse.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.springboot.hobbyverse.service.UserService;

@RestController
@RequestMapping("/user")
public class ChangePasswordController {
	@Autowired
	private UserService userService;
	
	@PostMapping("/changePassword")
	public ResponseEntity<String> changePassword(@RequestParam String currentPassword, @RequestParam String newPassword, @RequestParam String confirmPassword, Principal principal){
		if(!newPassword.equals(confirmPassword)) {
			return ResponseEntity.badRequest().body("비밀번호가 일치하지 않습니다.");
		}
		
		boolean isChange = userService.changePassword(principal.getName(), currentPassword, newPassword);
		if(isChange) {
				return ResponseEntity.badRequest().body("비밀번호가 변경되었습니다.");
		}else {
			return ResponseEntity.badRequest().body("비밀번호가 일치하지 않습니다.");
		}
		
	}
	
	
}
