package com.springboot.hobbyverse.controller;

import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.config.SecurityConfig;
import com.springboot.hobbyverse.dto.TopCategoryDTO;
import com.springboot.hobbyverse.dto.UpdateUserRequest;
import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.MeetingApply;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.Report;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.repository.UserRepository;
import com.springboot.hobbyverse.service.AdminSearchService;
import com.springboot.hobbyverse.service.InquiryService;
import com.springboot.hobbyverse.service.MeetingApplyService;
import com.springboot.hobbyverse.service.MeetingService;
import com.springboot.hobbyverse.service.ReportService;
import com.springboot.hobbyverse.service.ReportService;
import com.springboot.hobbyverse.service.UserActivityService;
import com.springboot.hobbyverse.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminController {
	private final UserService userService;
	private final UserRepository userRepository;
	private final MeetingService meetingService;
	private final SecurityConfig securityConfig;
	private final InquiryService inquiryService; // 추가 (문의사항 서비스)
	private final UserActivityService userActivityService;
	private final AdminSearchService adminSearchService;
	private final MeetingApplyService meetingApplyService;
	private final ReportService reportService;

	// 관리자 전용 대시보드 경로
	@GetMapping("/dashboard")
	public ModelAndView dashboard() {
		ModelAndView mav = new ModelAndView("dashboard");

		Integer totalUser = this.userService.getUserCount(); // 총 유저 수
		Integer totalMeet = this.meetingService.getTotal(); // 총 모임 수
		Integer totalInquiries = this.inquiryService.getInquiryCount(); // 총 문의사항 수 추가
		List<TopCategoryDTO> topCategories = this.meetingService.getTopMeetingCategories();
		String userStatsSummary = userActivityService.getRecentUserStats();

		mav.addObject("userStats", userStatsSummary);
		mav.addObject("topCategories", topCategories);
		mav.addObject("totalUsers", totalUser);
		mav.addObject("totalMeet", totalMeet);
		mav.addObject("totalInquiries", totalInquiries); // 문의사항 개수 전달

		return mav;
	}

	// 맴버관리
	@GetMapping("/users")
	public ModelAndView userManagement(Integer PAGE_NUM) {
		ModelAndView mav = new ModelAndView("user_management");
		List<User> users = userRepository.findAll();
		// 페이지처리
		int currentPage = 1;
		if (PAGE_NUM != null)
			currentPage = PAGE_NUM;
		int count = this.userService.getUserCount();
		int startRow = 0;
		int endRow = 0;
		int totalPageCount = 0;
		if (count > 0) {
			totalPageCount = count / 5;
			if (count % 5 != 0)
				totalPageCount++;
			startRow = (currentPage - 1) * 5;
			endRow = ((currentPage - 1) * 5) + 5;
			if (endRow > count)
				endRow = count;
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
				user.setRegDateString("N/A"); // reg_date가 null일 경우 대체 값
			}
		}
		mav.addObject("users", userList);
		mav.addObject("START", startRow);
		mav.addObject("END", endRow);
		mav.addObject("TOTAL", count);
		mav.addObject("currentPage", currentPage);
		mav.addObject("LIST", userList);
		mav.addObject("pageCount", totalPageCount);
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

	// 유저 수정API
	@PutMapping("/user/edit/{id}")
	public ResponseEntity<Map<String, String>> updateUserByAdmin(@PathVariable Long id,
			@RequestBody UpdateUserRequest updateRequest) {
		Map<String, String> response = new HashMap<>();

		if (!userRepository.existsById(id)) {
			response.put("message", "유저를 찾을 수 없습니다.");
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}
		// 유저 정보 수정
		User user = userRepository.findByUserId(id);
		user.setName(updateRequest.getName());

		if (updateRequest.getPassword() != null && !updateRequest.getPassword().isEmpty()) {
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

	// 유저 삭제API
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

	// 모임 관리
	@GetMapping("/meetings")
	public ModelAndView meetingManagement(Integer PAGE_NUM) {
		ModelAndView mav = new ModelAndView("meeting_management");
		int currentPage = 1;
		if (PAGE_NUM != null)
			currentPage = PAGE_NUM;
		int start = (currentPage - 1) * 6;
		int end = start + 7;
		List<Meetup> meetList = this.meetingService.getMeetings(PAGE_NUM);
		int totalCount = this.meetingService.getTotal();
		int pageCount = totalCount / 6;
		if (totalCount % 6 != 0)
			pageCount++;

		mav.addObject("meetList", meetList);
		mav.addObject("start", start);
		mav.addObject("end", end);
		mav.addObject("total", totalCount);
		mav.addObject("pageCount", pageCount);
		mav.addObject("currentPage", currentPage);
		return mav;
	}

	// 모임수정
	@GetMapping("/meeting/edit/form/{id}")
	public ModelAndView editMeeting(@PathVariable Integer id, HttpSession session) {
		ModelAndView mav = new ModelAndView("updateGroup");
		User user = (User) session.getAttribute("loginUser");

		if (meetingService.getMeetingById(id) == null) {
			mav.addObject("error", "유저를 찾을 수 없습니다.");
			return mav;
		}
		Meetup meetup = this.meetingService.getMeetDetail(id); // 모임 정보 가져오기
		List<Category> categoryList = meetingService.getCategoryList(); // 카테고리 리스트 가져오기

		mav.addObject("user", user);
		mav.addObject("meetup", meetup); // 수정할 모임 정보 전달
		mav.addObject("categoryList", categoryList); // 카테고리 리스트 전달
		return mav;
	}

	// 모임 삭제
	@DeleteMapping("/meeting/delete/{id}")
	public ResponseEntity<Map<String, String>> deleteMeeting(@PathVariable Integer id) {
		Map<String, String> response = new HashMap<>();

		Integer meetingId = this.meetingService.deleteById(id);

		if (meetingId == null) {
			response.put("message", "모임을 찾을 수 없습니다.");
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}

		response.put("message", "모임을 성공적으로 삭제했습니다.");
		return ResponseEntity.status(HttpStatus.OK).body(response);
	}

	// 모임 이름으로 검색
	@RequestMapping("/searchMeet")
	public ModelAndView searchMeet(HttpSession session, String TITLE, Integer pageNo) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser");

		int currentPage = 1;
		if (pageNo != null)
			currentPage = pageNo;
		int start = (currentPage - 1) * 6;
		int end = start + 7;

		//session.setAttribute("TITLE", TITLE);
		List<Meetup> meetList = this.adminSearchService.searchMeet(TITLE, pageNo);
		int totalCount = this.adminSearchService.searchMeetCount(TITLE);
		int pageCount = totalCount / 6;
		if (totalCount % 6 != 0)
			pageCount++;
		mav.addObject("meetList", meetList);
		mav.addObject("user", user);
		mav.addObject("TITLE", TITLE);
		mav.addObject("start", start);
		mav.addObject("end", end);
		mav.addObject("total", totalCount);
		mav.addObject("pageCount", pageCount);
		mav.addObject("currentPage", currentPage);
		mav.setViewName("meeting_managementResult");
		return mav;
	}

	// 이메일, 이름으로 검색
	@RequestMapping("/searchUser")
	public ModelAndView searchUser(HttpSession session, Integer pageNo, String SEARCH) {
		ModelAndView mav = new ModelAndView();
		User users = (User) session.getAttribute("loginUser");

		int currentPage = 1;
		if (pageNo != null)
			currentPage = pageNo;
		int start = (currentPage - 1) * 6;
		int end = start + 7;

		//session.setAttribute("SEARCH", SEARCH);
		List<User> userList = this.adminSearchService.searchUser(SEARCH, pageNo);

		int totalCount = this.adminSearchService.searchUserCount(SEARCH);
		int pageCount = totalCount / 6;
		if (totalCount % 6 != 0)
			pageCount++;

		// LocalDateTime 포맷터 설정
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		for (User user : userList) {
			if (user.getRegDate() != null) {
				// LocalDateTime을 String으로 포맷
				String formattedDate = user.getRegDate().format(formatter);
				user.setRegDateString(formattedDate);
			} else {
				user.setRegDateString("N/A"); // reg_date가 null일 경우 대체 값
			}
		}

		mav.addObject("userList", userList);
		mav.addObject("user", users);
		mav.addObject("SEARCH", SEARCH);
		mav.addObject("start", start);
		mav.addObject("end", end);
		mav.addObject("total", totalCount);
		mav.addObject("pageCount", pageCount);
		mav.addObject("currentPage", currentPage);
		mav.setViewName("user_managementResult");
		return mav;
	}

	// 가입자 보기
	@GetMapping("/showUserList")
	public ModelAndView showUser(HttpSession session, Integer m_id) {
		ModelAndView mav = new ModelAndView("userList");
		List<MeetingApply> showUser = meetingApplyService.joinedUser(m_id);
		mav.addObject("showUser", showUser);

		return mav;
	}

	// 신고된 모임 확인
	@GetMapping("/reports")
	public ModelAndView reports(Integer PAGE_NUM, HttpSession session) {
		ModelAndView mav = new ModelAndView("report_management");
		User user = (User) session.getAttribute("loginUser");
		int currentPage = 1;
		if (PAGE_NUM != null)
			currentPage = PAGE_NUM;
		int start = (currentPage - 1) * 10;
		int end = start + 11;
		List<Report> reportList = this.reportService.getReportList(PAGE_NUM); // 신고 목록
		List<Meetup> meetList = this.reportService.getReportedMeeting(); // 모임별 신고 횟수
		Integer totalCount = this.reportService.getReportTotal();
		int pageCount = totalCount / 10;
		if (totalCount % 10 != 0)
			pageCount++;
		mav.addObject("START", start);
		mav.addObject("END", end);
		mav.addObject("TOTAL", totalCount);
		mav.addObject("LIST", meetList);
		mav.addObject("pageCount", pageCount);
		mav.addObject("currentPage", currentPage);
		mav.addObject("reportList", reportList);
		mav.addObject("meetList", meetList);
		mav.addObject("user", user);

		return mav;
	}

	// 신고된 모임 상세
	@GetMapping("/reportsDetail")
	public ModelAndView reportsDetail(Integer report_id, HttpSession session) {
		ModelAndView mav = new ModelAndView("reportsDetail");
		User user = (User) session.getAttribute("loginUser");
		Report report = this.reportService.getReportDetail(report_id);// 해당 신고 정보 조회
		List<Meetup> meetList = this.reportService.getMeetingList(); // 모임 리스트 조회
		mav.addObject("report", report);
		mav.addObject("meetList", meetList); // meetList 추가
		mav.addObject("report_id", report_id);
		mav.addObject("user", user);
		return mav;
	}

	// 신고된 모임 삭제
	@DeleteMapping("/reportsDelete/{report_id}")
	public ResponseEntity<Map<String, String>> reportsDelete(@PathVariable Integer report_id) {
		Map<String, String> response = new HashMap<>();
		this.reportService.deleteReports(report_id);
		if (report_id == null) {
			response.put("message", "모임을 찾을 수 없습니다.");
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}
		response.put("message", "모임을 성공적으로 삭제했습니다.");
		return ResponseEntity.status(HttpStatus.OK).body(response);
	}

	@GetMapping("/reportsSearch")
	public ModelAndView reportsSearch(String title, Integer PAGE_NUM, HttpSession session) {
		ModelAndView mav = new ModelAndView("reportSearchGroup");
		User user = (User) session.getAttribute("loginUser");
		int currentPage = 1;
		if (PAGE_NUM != null)
			currentPage = PAGE_NUM;
		int start = (currentPage - 1) * 10;
		int end = start + 11;
		List<Report> reportList = this.reportService.getReportByTitle(title, PAGE_NUM); // 신고 목록
		List<Meetup> meetList = this.reportService.getReportedMeeting(); // 모임별 신고 횟수
		Integer totalCount = this.reportService.getReportCountByTitle(title);
		int pageCount = totalCount / 10;
		if (totalCount % 10 != 0)
			pageCount++;
		mav.addObject("START", start);
		mav.addObject("END", end);
		mav.addObject("TOTAL", totalCount);
		mav.addObject("LIST", meetList);
		mav.addObject("pageCount", pageCount);
		mav.addObject("currentPage", currentPage);
		mav.addObject("reportList", reportList);
		mav.addObject("meetList", meetList);
		mav.addObject("title", title);
		mav.addObject("user", user);
		return mav;
	}
       return mav;
   }
   
   //신고된 모임 상세
   @GetMapping("/reportsDetail")
   public ModelAndView reportsDetail(Integer report_id, HttpSession session) {
       ModelAndView mav = new ModelAndView("reportsDetail");
       User user = (User)session.getAttribute("loginUser");
       
       Report report = this.reportService.getReportDetail(report_id);// 해당 신고 정보 조회
       List<Meetup> meetList = this.reportService.getMeetingList(); // 모임 리스트 조회
       
       mav.addObject("report", report);
       mav.addObject("meetList", meetList); // meetList 추가
       mav.addObject("report_id", report_id);
       mav.addObject("user", user);
       return mav;
   }
   
   //신고된 모임 삭제
   @DeleteMapping("/reportsDelete/{report_id}")
   public ResponseEntity<Map<String, String>> reportsDelete(@PathVariable Integer report_id){
   	Map<String, String> response = new HashMap<>();   	
   	this.reportService.deleteReports(report_id);  	
   	if(report_id == null) {
       	response.put("message", "모임을 찾을 수 없습니다.");
       	return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
   	}   	
       response.put("message", "모임을 성공적으로 삭제했습니다.");
       return ResponseEntity.status(HttpStatus.OK).body(response);
   }
   
   @GetMapping("/reportsSearch")
   public ModelAndView reportsSearch(String title, Integer PAGE_NUM, HttpSession session) {
       ModelAndView mav = new ModelAndView("reportSearchGroup");
       User user = (User) session.getAttribute("loginUser");
       int currentPage = 1;
       if (PAGE_NUM != null) currentPage = PAGE_NUM;
       int start = (currentPage - 1) * 10; 
       int end = start + 11;       
       List<Report> reportList = this.reportService.getReportByTitle(title, PAGE_NUM); // 신고 목록
       List<Meetup> meetList = this.reportService.getReportedMeeting(); // 모임별 신고 횟수
       Integer totalCount = this.reportService.getReportCountByTitle(title);
       int pageCount = totalCount / 10;
       if(totalCount % 10 != 0) pageCount++;
       mav.addObject("START", start);
       mav.addObject("END", end);
       mav.addObject("TOTAL", totalCount);
       mav.addObject("LIST",meetList); 
       mav.addObject("pageCount", pageCount);
       mav.addObject("currentPage", currentPage);
       mav.addObject("reportList", reportList);
       mav.addObject("meetList", meetList);
       mav.addObject("title", title);
       mav.addObject("user", user);
       return mav;
   }  
}