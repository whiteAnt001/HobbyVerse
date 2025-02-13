package com.springboot.hobbyverse.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.repsitory.UserRepository;
import com.springboot.hobbyverse.service.UserService;

import jakarta.servlet.http.HttpSession;
import org.springframework.transaction.annotation.Transactional;

@RestController
@RequestMapping("/api/users")
public class UserApiController {
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private UserService userService;
	
	@DeleteMapping("/delete")
	@Transactional
	public ResponseEntity<Map<String, String>> deleteAccount(HttpSession session){
		User user = (User) session.getAttribute("loginUser");
		Map<String, String> response = new HashMap<>();
		String email = user.getEmail(); // 로그인된 사용자의 ID를 가져옴
		User userEmail = userRepository.findByEmail(email);
		
		if (userEmail == null) {
			response.put("message", "유저를 찾을 수 없습니다.");
        	return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        }
		
		//유저 삭제하기
		userRepository.deleteByEmail(email); 
		// 세션 무효화 - 탈퇴 후 세션을 종료
		session.invalidate();
		    
        response.put("message", "유저를 성공적으로 삭제했습니다.");
        return ResponseEntity.status(HttpStatus.OK).body(response);
	}
}
