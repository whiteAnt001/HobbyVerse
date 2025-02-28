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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.config.SecurityConfig;
import com.springboot.hobbyverse.dto.UpdateUserRequest;
import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.repository.UserRepository;
import com.springboot.hobbyverse.service.InquiryService;
import com.springboot.hobbyverse.service.MeetingService;
import com.springboot.hobbyverse.service.UserService;

@RestController
@RequestMapping("/api/admin")
public class AdminController {
    @Autowired
    private UserService userService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private MeetingService meetingService;
    @Autowired
    private SecurityConfig securityConfig;
    @Autowired
    private InquiryService inquiryService; // ✅ 추가 (문의사항 서비스)
    //관리자 전용 대시보드 경로
    @GetMapping("/dashboard")
    public ModelAndView dashboard() { 
        ModelAndView mav = new ModelAndView("dashboard");
        Integer totalUser = this.userService.getUserCount(); // 총 유저 수
        Integer totalMeet = this.meetingService.getTotal(); // 총 모임 수
        Integer totalInquiries = this.inquiryService.getInquiryCount(); // ✅ 총 문의사항 수 추가

        mav.addObject("totalUsers", totalUser);
        mav.addObject("totalMeet", totalMeet);
        mav.addObject("totalInquiries", totalInquiries); // ✅ 문의사항 개수 전달

        return mav;
    }
    
    //맴버관리
    @GetMapping("/users")
    public ModelAndView userManagement(Integer PAGE_NUM) {
        ModelAndView mav = new ModelAndView("user_management"); 
        List<User> users = userRepository.findAll();
        //페이지처리
        int currentPage = 1;
        if (PAGE_NUM != null) currentPage = PAGE_NUM;
        int count = this.userService.getUserCount();
        int startRow = 0; int endRow = 0; int totalPageCount = 0;
        if (count > 0) {
            totalPageCount = count / 5;
            if (count % 5 != 0) totalPageCount++;           
            startRow = (currentPage - 1) * 5;
            endRow = ((currentPage - 1) * 5) + 5;           
            if (endRow > count) endRow = count;
        }
        List<User> userList = this.userService.getUserList(PAGE_NUM);
        
        // LocalDateTime 포맷터 설정
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        for (User user : userList) {
            if (user.getRegDate() != null) {
                // LocalDateTime을 String으로 포맷
                String formattedDate = user.getRegDate().format(formatter);
                user.setRegDateString(formattedDate);
            } else {
                user.setRegDateString("N/A");  // reg_date가 null일 경우 대체 값
            }
        }
        mav.addObject("users", userList);
        mav.addObject("START",startRow); mav.addObject("END", endRow);
		mav.addObject("TOTAL", count); mav.addObject("currentPage",currentPage);
		mav.addObject("LIST",userList); mav.addObject("pageCount",totalPageCount);
        mav.addObject("userList", userList);
        return mav;
    } 
    
    // 유저 수정 폼 페이지
    @GetMapping("/user/edit/form/{id}")
    public ModelAndView editUserForm(@PathVariable Long id) {
        ModelAndView mav = new ModelAndView("user_modify"); // edit_user.jsp로 연결
        User user = userRepository.findById(id).orElse(null);
        if (user == null) {
            mav.addObject("error", "유저를 찾을 수 없습니다.");
            return mav;
        }
        mav.addObject("user", user);
        return mav;
    }

    //유저 수정API
    @PutMapping("/user/edit/{id}")
    public ResponseEntity<Map<String, String>> updateUserByAdmin(@PathVariable Long id, @RequestBody UpdateUserRequest updateRequest){
    	Map<String, String> response = new HashMap<>();
    	
    	if(!userRepository.existsById(id)) {
    		response.put("message", "유저를 찾을 수 없습니다.");
        	return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
    	}
    	//유저 정보 수정
    	User user = userRepository.findByUserId(id);
    	user.setName(updateRequest.getName());
    	
    	if(updateRequest.getPassword() != null && !updateRequest.getPassword().isEmpty()) {
    		user.setPassword(securityConfig.passwordEncoder().encode(updateRequest.getPassword()));
    	}
    	user.setRole(updateRequest.getRole());
    	
    	userRepository.save(user);
    	
    	response.put("message", "유저 정보가 성공적으로 수정되었습니다.");
    	return ResponseEntity.status(HttpStatus.OK).body(response);
    }
    
//    //이름 중복 체크 API 
//    @GetMapping("/user/nameCheck")
//    public ResponseEntity<Map<String, String>> checkUserName(@RequestParam String name) {
//        Map<String, String> response = new HashMap<>();
//
//        // 정확히 동일한 이름만 중복 체크
//        if (userRepository.existsByName(name)) {
//            response.put("message", "이미 존재하는 이름입니다.");
//            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
//        }
//
//        response.put("message", "사용 가능한 이름입니다.");
//        return ResponseEntity.status(HttpStatus.OK).body(response);
//    }

    
    //유저 삭제API
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
    public ModelAndView meetingManagement(Integer PAGE_NUM) {
        ModelAndView mav = new ModelAndView("meeting_management");
        int currentPage = 1;
        if (PAGE_NUM != null) currentPage = PAGE_NUM;
        int count = this.meetingService.getTotal();
        int startRow = 0; int endRow = 0; int totalPageCount = 0;
        if (count > 0) {
            totalPageCount = count / 10;
            if (count % 10 != 0) totalPageCount++;           
            startRow = (currentPage - 1) * 10;
            endRow = ((currentPage - 1) * 10) + 10;           
            if (endRow > count) endRow = count;
        }
        List<Meetup> meetList = this.meetingService.getMeetings(PAGE_NUM);
        mav.addObject("START",startRow); 
		mav.addObject("END", endRow);
		mav.addObject("TOTAL", count);	
		mav.addObject("currentPage",currentPage);
		mav.addObject("pageCount",totalPageCount);
		mav.addObject("LIST",meetList);
        mav.addObject("meetList", meetList);
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