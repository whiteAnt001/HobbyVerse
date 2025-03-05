package com.springboot.hobbyverse.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.Board;
import com.springboot.hobbyverse.model.MeetingApply;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.model.UserActivity;
import com.springboot.hobbyverse.repository.BoardRepository;
import com.springboot.hobbyverse.repository.UserRepository;
import com.springboot.hobbyverse.service.MeetingApplyService;
import com.springboot.hobbyverse.service.MeetingService;
import com.springboot.hobbyverse.service.MyPageService;
import com.springboot.hobbyverse.service.UserActivityService;
import com.springboot.hobbyverse.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class MyPageController {
	private final UserService userService;
	private final MyPageService myPageService;
	private final BoardRepository boardRepository;
	private final UserRepository userRepository;
	private final MeetingService meetingService;
	private final UserActivityService userActivityService;

	
	//마이페이지 메인
	@GetMapping("/myPage")
	public ModelAndView mypage(HttpSession session) {
		ModelAndView mav = new ModelAndView("myPage");
		
	    User user = (User) session.getAttribute("loginUser");	    
	    if (user == null) {
	        // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
	        mav.setViewName("/login");
	        return mav;
	    }
	    
	    // 비밀번호 변경 후 메시지 전달
	    String message = (String) session.getAttribute("message");
	    if (message != null) {
	        mav.addObject("message", message); // 메시지를 모델에 추가
	        session.removeAttribute("message");  // 메시지 처리 후 세션에서 제거
	    }
	    
	    mav.addObject("user", user);
	    return mav;
	}
	
	//비밀번호 변경
	@GetMapping("/myPage/changePassword")
	public ModelAndView changePassword() {
		return new ModelAndView("myPage_changePassword");
	}
	
	//내가 만든 모임
	@GetMapping("/myPage/myMeetings")
	public ModelAndView myMeetings(HttpSession session) {
		ModelAndView mav = new ModelAndView("myPage_myMeetings");
		User user = (User)session.getAttribute("loginUser");
		List<Meetup> createMeetings = myPageService.getCreateMeetings(user.getEmail());
		mav.addObject("user", user);
		mav.addObject("createdMeetings", createMeetings);
		return mav;
	}
	
	//참여 신청한 모임
	@GetMapping("/myPage/joinedMeetings")
	public ModelAndView joinedMeetings(HttpSession session) {
		ModelAndView mav = new ModelAndView("myPage_joinedMeetings");
		User user = (User)session.getAttribute("loginUser");
		List<MeetingApply> meetingApply = myPageService.meetingList(user.getUserId());
		mav.addObject("meetingApply", meetingApply);
		mav.addObject("user", user);
		return mav;
	}      
	
	//내가 쓴 게시글
	@GetMapping("/myPage/myPosts")
	public ModelAndView myPosts(HttpSession session) {
		ModelAndView mav = new ModelAndView("myPage_myPosts");
		User user = (User)session.getAttribute("loginUser");
		List<Board> myPosts = boardRepository.findByName(user.getName());
		mav.addObject("user", user);
		mav.addObject("myPosts", myPosts);
		return mav;
		
	}
	
	// 비밀번호 변경 폼
	@GetMapping("/myPage/form/changePassword")
	public ModelAndView changePasswordForm(HttpSession session) {
		ModelAndView mav = new ModelAndView("myPage_changePassword");
		User user = (User)session.getAttribute("loginUser");
		mav.addObject("user", user);
		return mav;
	}
	
	// 비밀번호 변경
	@PostMapping("/api/myPage/changePassword")
	public ResponseEntity<Map<String, String>> changePassword(@RequestParam String currentPassword,
	                                                           @RequestParam String newPassword,
	                                                           @RequestParam String confirmPassword,
	                                                           HttpSession session) {
	    Map<String, String> response = new HashMap<>();
	    User user = (User) session.getAttribute("loginUser");

	    // 비밀번호 일치 여부 확인
	    if (!newPassword.equals(confirmPassword)) {
	        response.put("message", "새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
	        return ResponseEntity.badRequest().body(response);
	    } else if (user.getPassword().equals(newPassword)) {
	        response.put("message", "현재 비밀번호와 새 비밀번호가 같습니다.");
	        return ResponseEntity.badRequest().body(response);
	    }

	    // 비밀번호 변경 시도
	    boolean isChange = userService.changePassword(user.getUsername(), currentPassword, newPassword);

	    if (isChange) {
	        response.put("message", "비밀번호가 성공적으로 변경되었습니다.");
	        return ResponseEntity.ok(response);
	    } else {
	        response.put("message", "현재 비밀번호가 올바르지 않습니다.");
	        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(response);
	    }
	}
	//회원 탈퇴 폼
	@GetMapping("/myPage/form/deleteAccount")
	public ModelAndView deleteAccountForm(HttpSession session) {
		ModelAndView mav = new ModelAndView("myPage_deleteAccount");
		User user = (User) session.getAttribute("loginUser");
		mav.addObject("user", user);
		return mav;
	}
	//회원 탈퇴
	@DeleteMapping("/api/myPage/deleteAccount")
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
		
		UserActivity deleteUserActivity = UserActivity.builder()
				.activityDate(LocalDate.now())
				.newUsers(0)
				.unsubscribedUsers(1) //탈퇴한 유저
				.joinedMeetings(0)
				.build();
		
		//유저 동향 업데이트
		userActivityService.saveUserActivity(deleteUserActivity);
		
		//유저 삭제하기
		userRepository.deleteByEmail(email); 
		// 세션 무효화 - 탈퇴 후 세션을 종료
		session.invalidate();
		    
        response.put("message", "유저를 성공적으로 삭제했습니다.");
        return ResponseEntity.status(HttpStatus.OK).body(response);
	}
	
	
}
