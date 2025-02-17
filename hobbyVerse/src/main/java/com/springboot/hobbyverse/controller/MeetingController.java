package com.springboot.hobbyverse.controller;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.Meetup;
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

	@GetMapping("/home")
	public ModelAndView getHome(Integer PAGE_NUM, HttpSession session) {
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
        mav.addObject("user", user);
		mav.addObject("START",startRow); 
		mav.addObject("END", endRow);
		mav.addObject("TOTAL", count);	
		mav.addObject("currentPage",currentPage);
		mav.addObject("LIST",meetList); 
		mav.addObject("pageCount",totalPageCount);
        mav.addObject("meetList", meetList);
        return mav;
	}

    @GetMapping(value = "/meetup/createGroup.html")
    public ModelAndView entry(HttpSession session) {
        ModelAndView mav = new ModelAndView("createGroup");
        List<Category> categoryList = meetingService.getCategoryList();
        User user = (User)session.getAttribute("loginUser");
        mav.addObject(new Meetup());
        mav.addObject("user", user);
        mav.addObject("categoryList", categoryList);
        return mav;
    }//모임등록창

    @PostMapping("/meetup/register.html")
    public ModelAndView register(Meetup meetup, BindingResult br, HttpSession session, 
                HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView();
        User user = (User)session.getAttribute("loginUser");
        meetup.setW_id(user.getUsername());
        MultipartFile multiFile = meetup.getFile();
        String fileName = null;
        String path = null;
        OutputStream out = null;
        fileName = multiFile.getOriginalFilename();
        if (!fileName.equals("")) {
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
                } catch (Exception e) {}
            }
            meetup.setImagename(fileName);
        }
        this.meetingService.putMeeting(meetup);
        mav.setViewName("createGroupDone");
        mav.addObject("meetup", meetup);
        mav.addObject("user",user);
        mav.addObject("message", "모임이 등록되었습니다.");
        return mav;
    }//모임등록
    
    @GetMapping(value = "/meetup/detail.html")
    public ModelAndView detail(Integer id, HttpSession session) {
    	ModelAndView mav = new ModelAndView("detailGroup");
        Meetup meetup = this.meetingService.getMeetDetail(id);
        User user = (User) session.getAttribute("loginUser");
        mav.addObject("user", user);
        mav.addObject("meetup", meetup);
        return mav;
    }//모임 상세보기
    
    @GetMapping("/meetup/modify.html")
    public ModelAndView modify(Integer m_id, String BTN) {
        ModelAndView mav = new ModelAndView();

        if ("수정".equals(BTN)) {
            // 수정 버튼 클릭 시
            Meetup meetup = this.meetingService.getMeetDetail(m_id); // 모임 정보 가져오기
            List<Category> categoryList = meetingService.getCategoryList(); // 카테고리 리스트 가져오기

            mav.setViewName("updateGroup"); // 수정 화면으로 이동
            mav.addObject("meetup", meetup); // 수정할 모임 정보 전달
            mav.addObject("categoryList", categoryList); // 카테고리 리스트 전달
        } else if ("삭제".equals(BTN)) {
            // 삭제 버튼 클릭 시
            this.meetingService.deleteMeeting(m_id); // 모임 삭제
            mav.setViewName("deleteGroupSuccess"); // 삭제 완료 화면으로 이동
            mav.addObject("message", "삭제되었습니다."); // 삭제 메시지 전달
        }

        return mav;
    }



    @PostMapping("/meetup/update.html")
    public ModelAndView update(Meetup meetup, HttpSession session) {
    	ModelAndView mav = new ModelAndView();
        MultipartFile multiFile = meetup.getFile();
      
        if (! multiFile.getOriginalFilename().equals("")) {
        	String fileName = null; String path = null; OutputStream os = null;
        	fileName = multiFile.getOriginalFilename();
        	ServletContext ctx = session.getServletContext();
        	path = ctx.getRealPath("/upload/"+fileName);
        	System.out.println("변경된 이미지 경로:"+path);
            
            try {
            	os = new FileOutputStream(path);
            	BufferedInputStream bis = 
    					new BufferedInputStream(multiFile.getInputStream());
            	byte[] buffer = new byte[8156];
            	int read = 0;
            	while((read = bis.read(buffer)) > 0) {
            		os.write(buffer, 0, read);
            	}
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("변경된 이미지 업로드 중 문제발생!");
            }finally {
				try {
					if(os != null) os.close();
				}catch(Exception e) {}
            }
            meetup.setImagename(fileName);
        }
        this.meetingService.updateMeeting(meetup);
        mav.setViewName("updateGroupSuccess");
        mav.addObject("message","모임이 성공적으로 수정되었습니다.");
        mav.addObject("meetup", meetup);
        return mav;
    }//모임 수정
}