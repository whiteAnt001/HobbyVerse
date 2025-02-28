package com.springboot.hobbyverse.controller;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.Recommend;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.service.MeetingService;
import com.springboot.hobbyverse.service.UserService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class MeetingController {

	@Autowired
	private UserService userService;
    @Autowired 
    private MeetingService meetingService;

    @GetMapping(value = "/home")
    public ModelAndView index(Integer PAGE_NUM, HttpSession session) {
    	User user = (User)session.getAttribute("loginUser");
		int currentPage = 1;
        if (PAGE_NUM != null) currentPage = PAGE_NUM;
        int count = this.meetingService.getTotal();
        int startRow = 0; int endRow = 0; int totalPageCount = 0;
        if (count > 0) {
            totalPageCount = count / 6;
            if (count % 6 != 0) totalPageCount++;           
            startRow = (currentPage - 1) * 6;
            endRow = ((currentPage - 1) * 6) + 6;           
            if (endRow > count) endRow = count;
        }
        List<Meetup> meetList = this.meetingService.getMeetList(PAGE_NUM);
        ModelAndView mav = new ModelAndView("index");
        mav.addObject("user",user);
		mav.addObject("START",startRow); 
		mav.addObject("END", endRow);
		mav.addObject("TOTAL", count);	
		mav.addObject("currentPage",currentPage);
		mav.addObject("LIST",meetList); 
		mav.addObject("pageCount",totalPageCount);
        mav.addObject("meetList", meetList);
        return mav;
    }//모임목록,페이지처리

    @PostMapping(value = "/meetup/search.html")
    public ModelAndView search(String title, Integer pageNo, HttpSession session) {
        int currentPage = 1;
        if (pageNo != null) currentPage = pageNo;
        int start = (currentPage - 1) * 6; 
        int end = start + 7;
        List<Meetup> meetList = this.meetingService.getMeetByTitle(title, currentPage);
        Integer totalCount = this.meetingService.getMeetCountByTitle(title);
        User user = (User) session.getAttribute("loginUser");
        int pageCount = totalCount / 5;
        if(totalCount % 5 != 0) pageCount++;
        ModelAndView mav = new ModelAndView("searchGroupList");
        mav.addObject("user", user);
        mav.addObject("START", start);
        mav.addObject("END", end);
        mav.addObject("TOTAL", totalCount);
        mav.addObject("LIST",meetList); 
        mav.addObject("meetList", meetList);
        mav.addObject("pageCount", pageCount);
        mav.addObject("currentPage", currentPage);
        mav.addObject("title", title);
        return mav;
    }//모임제목으로 모임 검색
    
    @GetMapping(value = "/meetup/createGroup.html")
    public ModelAndView entry(Meetup meetup, HttpSession session) {
        List<Category> categoryList = meetingService.getCategoryList();
        ModelAndView mav = new ModelAndView("createGroup");
        User user = (User)session.getAttribute("loginUser");
        meetup.setW_id(user.getUsername());
        mav.addObject(new Meetup());
        mav.addObject("user",user);
        mav.addObject("categoryList", categoryList);
        return mav;
    }//모임등록창
    
    @PostMapping("/meetup/register.html")
    public ModelAndView register(Meetup meetup, BindingResult br, HttpSession session, 
                HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView();
        User user = (User) session.getAttribute("loginUser");
        meetup.setW_id(user.getUsername());
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
                    if (out != null) out.close();
                    if (bis != null) bis.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            meetup.setImagename(fileName);
        }        
        // 모임 등록
        this.meetingService.putMeeting(meetup);      
        mav.setViewName("createGroupDone");
        mav.addObject("message", "모임이 등록되었습니다.");
        return mav;
    }//모임등록

    @GetMapping(value = "/meetup/recommend.html")
    public ModelAndView recommend(Recommend recommend, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        User user = (User) session.getAttribute("loginUser");
        if (user == null) { // 로그인되지 않은 경우
            mav.setViewName("recommendGroupDone");  // 로그인 페이지로 리다이렉트
            mav.addObject("message", "로그인이 필요합니다.");
            mav.addObject("redirectUrl","/login");
            return mav;
        }
        recommend.setEmail(user.getEmail());
        Integer count = this.meetingService.getRecommendCheck(recommend.getM_id(),recommend.getEmail());
        if(count > 0) {
        	mav.addObject("message", "이미 추천한 모임입니다.");
        }else {
        	this.meetingService.putRecommend(recommend.getM_id(), recommend.getEmail());
        	mav.addObject("message", "추천이 완료되었습니다.");
        }
        mav.setViewName("recommendGroupDone");
        mav.addObject("recommend", recommend);
        mav.addObject("user", user);
        return mav;
    }//추천하기

    @GetMapping(value = "/meetup/detail.html")
    public ModelAndView detail(Integer id, HttpSession session) {
        ModelAndView mav = new ModelAndView("detailGroup");
        Meetup meetup = this.meetingService.getMeetDetail(id);     
        // 조회수 증가 처리
        this.meetingService.incrementViews(id);       
        // 최신 조회수 가져오기
        Integer views = this.meetingService.getViews(id);         
        User user = (User) session.getAttribute("loginUser");       
        mav.addObject("user", user);
        mav.addObject("meetup", meetup);
        mav.addObject("views", views); // 조회수 추가       
        return mav;
    }//모임 상세보기
    
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
            this.meetingService.deleteById(m_id);
            mav.setViewName("deleteGroupDone");
            mav.addObject("meetup", meetup);
            mav.addObject("BTN", "삭제");
        }
        return mav;
    }
    
    @PostMapping("/meetup/update.html")
    public ModelAndView update(Meetup meetup, HttpSession session) {
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
            meetup.setImagename(fileName);
        }
        // 모임 수정 처리
        this.meetingService.updateMeeting(meetup);
        mav.setViewName("updateGroupDone");
        mav.addObject("message", "모임이 성공적으로 수정되었습니다.");
        mav.addObject("meetup", meetup);
        return mav;
    }
}