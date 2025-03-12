package com.springboot.hobbyverse.controller;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.time.LocalDateTime;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.MeetingApply;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.Recommend;
import com.springboot.hobbyverse.model.Report;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.repository.MeetupRepository;
import com.springboot.hobbyverse.service.MeetingApplyService;
import com.springboot.hobbyverse.service.MeetingService;
import com.springboot.hobbyverse.service.ReportService;
import com.springboot.hobbyverse.service.UserService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class MeetingController {
	private static final Logger logger = LoggerFactory.getLogger(MeetingService.class);

	@Autowired
	private UserService userService;
	@Autowired
	private MeetingService meetingService;
	@Autowired
	private MeetingApplyService meetingApplyService;
	@Autowired
	private MeetupRepository meetupRepository;
	@Autowired
	private ReportService reportService;

	@GetMapping(value = "/home")
	public ModelAndView index(Integer PAGE_NUM, HttpSession session) {
		User user = (User) session.getAttribute("loginUser");
		int currentPage = 1;
		if (PAGE_NUM != null)
			currentPage = PAGE_NUM;
		int count = this.meetingService.getTotal();
		int startRow = 0;
		int endRow = 0;
		int totalPageCount = 0;
		if (count > 0) {
			totalPageCount = count / 4;
			if (count % 4 != 0)
				totalPageCount++;
			startRow = (currentPage - 1) * 4;
			endRow = ((currentPage - 1) * 4) + 4;
			if (endRow > count)
				endRow = count;
		}
		List<Meetup> meetList = this.meetingService.getMeetList(PAGE_NUM);
		ModelAndView mav = new ModelAndView("index");
		mav.addObject("user", user);
		mav.addObject("START", startRow);
		mav.addObject("END", endRow);
		mav.addObject("TOTAL", count);
		mav.addObject("currentPage", currentPage);
		mav.addObject("LIST", meetList);
		mav.addObject("pageCount", totalPageCount);
		mav.addObject("meetList", meetList);
		return mav;
	}// 모임목록,페이지처리

	@PostMapping(value = "/meetup/search.html")
	public ModelAndView searchPost(String title, Integer pageNo, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser");
		int currentPage = 1;
		if(pageNo != null) currentPage = pageNo;
		int start = (currentPage - 1) * 4;
		int end = start + 5;
		List<Meetup> meetList = this.meetingService.getMeetByTitle(title, pageNo);
		int totalCount = this.meetingService.getMeetCountByTitle(title);
		int pageCount = totalCount / 4;
		if(totalCount % 4 != 0) pageCount++;
		session.setAttribute("title", title);
		mav.addObject("meetList",  meetList);
		mav.addObject("user", user);
		mav.addObject("title", title);
		mav.addObject("start", start);
		mav.addObject("end", end);
		mav.addObject("total", totalCount);
		mav.addObject("pageCount", pageCount);
		mav.addObject("currentPage", currentPage);
		mav.setViewName("searchGroupList");
		return mav;
	}// 모임제목으로 모임 검색 
	
	@GetMapping(value = "/meetup/search.html")
	public ModelAndView searchGet(String title, Integer pageNo, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser");
		int currentPage = 1;
		if(pageNo != null) currentPage = pageNo;
		int start = (currentPage - 1) * 4;
		int end = start + 5;
		List<Meetup> meetList = this.meetingService.getMeetByTitle(title, pageNo);
		int totalCount = this.meetingService.getMeetCountByTitle(title);
		int pageCount = totalCount / 4;
		if(totalCount % 4 != 0) pageCount++;
		session.setAttribute("title", title);
		mav.addObject("meetList",  meetList);
		mav.addObject("user", user);
		mav.addObject("title", title);
		mav.addObject("start", start);
		mav.addObject("end", end);
		mav.addObject("total", totalCount);
		mav.addObject("pageCount", pageCount);
		mav.addObject("currentPage", currentPage);
		mav.setViewName("searchGroupList");
		return mav;
	}// 모임제목으로 모임 검색 (검색 후 페이지 변경)

	@GetMapping(value = "/meetup/createGroup.html")
	public ModelAndView entry(Meetup meetup, HttpSession session) {
		List<Category> categoryList = meetingService.getCategoryList();
		ModelAndView mav = new ModelAndView("createGroup");
		User user = (User) session.getAttribute("loginUser");
		meetup.setW_id(user.getName());
		mav.addObject(new Meetup());
		mav.addObject("user", user);
		mav.addObject("categoryList", categoryList);
		return mav;
	}// 모임등록창

	@PostMapping("/meetup/register.html")
	public ModelAndView register(Meetup meetup, BindingResult br, HttpSession session, HttpServletRequest request, @RequestParam String latitude, @RequestParam String longitude, @RequestParam String address)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser");
		meetup.setW_id(user.getName());
		meetup.setEmail(user.getEmail());
        // Meetup 객체에 주소, 위도, 경도 저장
		// 위치 정보가 비어있을 경우 예외 처리
	    // 위치 정보가 있을 경우 Meetup 객체에 저장
	    meetup.setLatitude(Double.parseDouble(latitude)); // 위도
	    meetup.setLongitude(Double.parseDouble(longitude)); // 경도
	    meetup.setAddress(address); // 주소
		MultipartFile multiFile = meetup.getFile();
		String fileName = null;
		String path = null;
		OutputStream out = null;
		fileName = multiFile.getOriginalFilename();
		if (!fileName.equals("")) {
			// 파일 업로드 경로 설정
			ServletContext ctx = session.getServletContext();
			path = ctx.getRealPath("/upload/" + fileName);
			BufferedInputStream bis = null;
			try {
				out = new FileOutputStream(path);
				bis = new BufferedInputStream(multiFile.getInputStream());
				byte[] buffer = new byte[8192];
				int read = 0;
				while ((read = bis.read(buffer)) > 0) {
					out.write(buffer, 0, read);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (out != null)
						out.close();
					if (bis != null)
						bis.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			meetup.setImagename(fileName);
		}
        meetup.setW_date(LocalDateTime.now());
		this.meetingService.putMeeting(meetup);
		meetupRepository.save(meetup);
		mav.setViewName("createGroupDone");
		mav.addObject("message", "모임이 등록되었습니다.");
		return mav;
	}// 모임등록

	@GetMapping(value = "/meetup/recommend.html")
	public ModelAndView recommend(Recommend recommend, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser");
		if (user == null) { // 로그인되지 않은 경우
			mav.setViewName("recommendGroupDone"); // 로그인 페이지로 리다이렉트
			mav.addObject("message", "로그인이 필요합니다.");
			mav.addObject("redirectUrl", "/login");
			return mav;
		}
		recommend.setEmail(user.getEmail());
		Integer count = this.meetingService.getRecommendCheck(recommend.getM_id(), recommend.getEmail());
		if (count > 0) {
			mav.addObject("message", "이미 추천한 모임입니다.");
		} else {
			this.meetingService.putRecommend(recommend.getM_id(), recommend.getEmail());
			mav.addObject("message", "추천이 완료되었습니다.");
		}
		mav.setViewName("recommendGroupDone");
		mav.addObject("recommend", recommend);
		mav.addObject("user", user);
		return mav;
	}// 추천하기

	// 홈에서 모임 자세히보기
	@GetMapping(value = "/meetup/detail.html")
	public ModelAndView detail(Integer id, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		// ✅ 조회수 증가 (DB 직접 업데이트)
		meetingService.incrementViewsDirectly(id);

		// ✅ 최신 데이터 강제 로드 (반드시 실행해야 최신 조회수 반영됨)
		Meetup meetup = meetingService.getMeetDetail(id);
		List<MeetingApply> meetingApplies = this.meetingApplyService.joinedUser(id);
		String wId = this.meetingService.getW_id(id);

		User user = (User) session.getAttribute("loginUser");
		if (user == null) { // 로그인이 안 되어 있는 경우
			// 로그인이 되어 있지 않으면 기본적인 모임 정보만 제공
			mav.setViewName("detailGroup");
			mav.addObject("meetup", meetup);
			mav.addObject("meetingApplies", meetingApplies);
			mav.addObject("views", meetup.getViews()); // ✅ 최신 조회수 반영
			logger.info("🔄 최신 조회수: {}", meetup.getViews()); // ✅ 콘솔에서 최신 조회수 확인
			return mav;
		}
		
		mav.setViewName("detailGroup");
		mav.addObject("user", user);
		mav.addObject("meetup", meetup);
		mav.addObject("meetingApplies", meetingApplies);
		mav.addObject("wId", wId);
		mav.addObject("views", meetup.getViews()); // ✅ 최신 조회수 반영

		logger.info("🔄 최신 조회수: {}", meetup.getViews()); // ✅ 콘솔에서 최신 조회수 확인
		return mav;

	}

	// 카테고리에서 모임(자세히 보기)들어간 경우일때 이전으로 버튼
	@GetMapping(value = "/meetup/detailCategory.html")
	public ModelAndView detailCategory(Integer id, HttpSession session) {
		// id => 모임 아이디
		ModelAndView mav = new ModelAndView();

		// ✅ 조회수 증가 (DB 직접 업데이트)
		meetingService.incrementViewsDirectly(id);

		// ✅ 최신 데이터 강제 로드 (반드시 실행해야 최신 조회수 반영됨)
		Meetup meetup = meetingService.getMeetDetail(id);
		List<MeetingApply> meetingApplies = this.meetingApplyService.joinedUser(id);
		String wId = this.meetingService.getW_id(id);

		User user = (User) session.getAttribute("loginUser");
		if (user == null) { // 로그인이 안 되어 있는 경우
			// 로그인이 되어 있지 않으면 기본적인 모임 정보만 제공
			mav.setViewName("detailGroup");
			mav.addObject("meetup", meetup);
			mav.addObject("meetingApplies", meetingApplies);
			mav.addObject("views", meetup.getViews()); // ✅ 최신 조회수 반영
			logger.info("🔄 최신 조회수: {}", meetup.getViews()); // ✅ 콘솔에서 최신 조회수 확인
			return mav;
		}
		
		mav.setViewName("detailGroupCategory");
		mav.addObject("user", user);
		mav.addObject("meetup", meetup);
		mav.addObject("meetingApplies", meetingApplies);
		mav.addObject("wId", wId);
		mav.addObject("views", meetup.getViews()); // ✅ 최신 조회수 반영

		logger.info("🔄 최신 조회수: {}", meetup.getViews()); // ✅ 콘솔에서 최신 조회수 확인
		return mav;
	}

	@GetMapping("/meetup/modify.html")
	public ModelAndView modify(Integer m_id, String BTN) {
		ModelAndView mav = new ModelAndView();
		Meetup meetup = this.meetingService.getMeetDetail(m_id);
		List<Category> categoryList = meetingService.getCategoryList();
		if ("수정".equals(BTN)) {
			// 수정 버튼 클릭 시 updateGroup.jsp(수정 폼)로 이동
			mav.setViewName("updateGroup"); // updateGroup.jsp
			mav.addObject("meetup", meetup);
			mav.addObject("categoryList", categoryList);
			mav.addObject("BTN", "수정");
		} else if ("삭제".equals(BTN)) {
			// 삭제 버튼 클릭 시 삭제 확인 페이지(modifyDone.jsp)로 이동
			// this.meetingService.deleteById(m_id);
			mav.setViewName("deleteGroupDone");
			mav.addObject("meetup", meetup);
			mav.addObject("BTN", "삭제");
		}
		return mav;
	}

	@PostMapping("/meetup/update.html")
	public ModelAndView update(Meetup meetup, HttpSession session, @RequestParam String latitude, @RequestParam String longitude, @RequestParam String address) {
		ModelAndView mav = new ModelAndView();
		// 파일 업로드 처리
	    if (meetup.getFile() != null && !meetup.getFile().getOriginalFilename().equals("")) {
	        String fileName = meetup.getFile().getOriginalFilename();
	        ServletContext ctx = session.getServletContext();
	        String path = ctx.getRealPath("/upload/" + fileName);
	        try (OutputStream os = new FileOutputStream(path);
	             BufferedInputStream bis = new BufferedInputStream(meetup.getFile().getInputStream())) {
	            byte[] buffer = new byte[8156];
	            int read;
	            while ((read = bis.read(buffer)) > 0) {
	                os.write(buffer, 0, read);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        meetup.setImagename(fileName);  // 새로운 파일명 저장
	    } else {
	        // 파일이 업로드되지 않았을 경우 기존 이미지 이름 그대로 사용
	        String existingImagename = meetingService.getExistingImagename(meetup.getM_id());
	        meetup.setImagename(existingImagename);
	    }   
	    if(latitude == null && latitude.trim().isEmpty() && longitude == null && longitude.trim().isEmpty()) {
	    	//위치가 변경 되었다면
	    	meetup.setLatitude(Double.parseDouble(latitude)); //변경된 위도 사용
	    	meetup.setLongitude(Double.parseDouble(longitude)); //변경된 경도 사용
	    }
        meetup.setAddress(address); // 주소
        // 모임 수정 처리
		this.meetingService.updateMeeting(meetup);
		mav.setViewName("updateGroupDone");
		mav.addObject("message", "모임이 성공적으로 수정되었습니다.");
		mav.addObject("meetup", meetup);
		return mav;
	}
	
    @GetMapping(value = "/meetup/report.html")
    public ModelAndView report(Integer m_id, Report report, HttpSession session) {
        ModelAndView mav = new ModelAndView("reportGroup");
        User user = (User) session.getAttribute("loginUser");
        report.setEmail(user.getEmail());
        Meetup meetup = meetingService.getMeetingById(m_id);
        mav.addObject("meetup", meetup);
        mav.addObject("report", report);
        mav.addObject("m_id",m_id);
        mav.addObject("user", user);

       return mav;

    }
    @PostMapping("/meetup/reportDo.html")
    public ModelAndView register(Report report, Integer m_id, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        User user = (User) session.getAttribute("loginUser");      
        report.setM_id(m_id);
        report.setEmail(user.getEmail());
        this.reportService.putReport(report);      
        mav.setViewName("reportGroupDone");
        mav.addObject("message", "신고가 접수되었습니다.");
        return mav;
    }//신고하기
}