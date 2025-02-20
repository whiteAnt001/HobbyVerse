package com.springboot.hobbyverse.controller;

import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.config.SecurityConfig;
import com.springboot.hobbyverse.dto.UpdateUserRequest;
import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.repository.UserRepository;
import com.springboot.hobbyverse.service.UserService;

@RestController
@RequestMapping("/api/admin")
public class AdminController {
    @Autowired
    private UserService userService;
    @Autowired
    private UserRepository userRepository;
    
    //관리자 전용 대시보드 경로
    @GetMapping("/dashboard")
    public ModelAndView dashboard() { // "deshboard" 오타 수정
        ModelAndView mav = new ModelAndView("dashboard");
        Integer userCount = this.userService.getUserCount();
        mav.addObject("totalUsers", userCount);
        return mav;
    }
    
    //맴버관리
    @GetMapping("/users")
    public ModelAndView userManagement() {
        ModelAndView mav = new ModelAndView("user_management"); 
        List<User> users = userRepository.findAll();
        
        // LocalDateTime 포맷터 설정
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss	");

        for (User user : users) {
            if (user.getRegDate() != null) {
                // LocalDateTime을 String으로 포맷
                String formattedDate = user.getRegDate().format(formatter);
                user.setRegDateString(formattedDate);
            } else {
                user.setRegDateString("N/A");  // reg_date가 null일 경우 대체 값
            }
        }
        mav.addObject("users", users);
        return mav;
    }
    
    //유저 삭제
    @DeleteMapping("/users/delete/{id}")
    public ResponseEntity<Map<String, String>> deleteUserByAdmin(@PathVariable Long id) {
    	Map<String, String> response = new HashMap<>();
    	
        if (!userRepository.existsById(id)) {
        	response.put("message", "유저를 찾을 수 없습니다.");
        	return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        }

        // 유저 삭제
        userRepository.deleteById(id);
        response.put("message", "유저를 성공적으로 삭제했습니다.");
        return ResponseEntity.status(HttpStatus.OK).body(response);
    }

    
    //모임 관리
    @GetMapping("/meetings")
    public ModelAndView meetingManagement() {
        ModelAndView mav = new ModelAndView("meeting_management");
        return mav;
    }
    
    @GetMapping("/meeting/edit/form/{id}")
    public ModelAndView editMeeting(@PathVariable Integer id) {
    	ModelAndView mav = new ModelAndView("updateGroup");
    	
        if (meetingService.getMeetingById(id) == null) {
            mav.addObject("error", "유저를 찾을 수 없습니다.");
            return mav;
        }
        Meetup meetup = this.meetingService.getMeetDetail(id); // 모임 정보 가져오기
        List<Category> categoryList = meetingService.getCategoryList(); // 카테고리 리스트 가져오기
        
        mav.addObject("meetup", meetup); // 수정할 모임 정보 전달
        mav.addObject("categoryList", categoryList); // 카테고리 리스트 전달
    	return mav;
    }
    
    //모임 삭제
    @DeleteMapping("/meeting/delete/{id}")
    public ResponseEntity<Map<String, String>> deleteMeeting(@PathVariable Integer id){
    	Map<String, String> response = new HashMap<>();
    	
    	Integer meetingId = this.meetingService.deleteById(id);
    	
    	if(meetingId == null) {
        	response.put("message", "모임을 찾을 수 없습니다.");
        	return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
    	}
    	
        response.put("message", "모임을 성공적으로 삭제했습니다.");
        return ResponseEntity.status(HttpStatus.OK).body(response);
    }
    
}
