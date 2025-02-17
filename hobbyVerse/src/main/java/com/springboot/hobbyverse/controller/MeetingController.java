package com.springboot.hobbyverse.controller;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
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

    @GetMapping(value = "/meetup/index.html")
    public ModelAndView index(Integer PAGE_NUM, HttpSession session) {
    	int currentPage = 1;
        if (PAGE_NUM != null) currentPage = PAGE_NUM;        
        int count = this.meetingService.getTotal();
        int startRow = 0;
        int endRow = 0;
        int totalPageCount = 0;
        if (count > 0) {
            totalPageCount = count / 6;
            if (count % 6 != 0) totalPageCount++;           
            startRow = (currentPage - 1) * 6;
            endRow = startRow + 6;           
            if (endRow > count) endRow = count;
        }
        List<Meetup> meetList = this.meetingService.getMeetList(PAGE_NUM);
        ModelAndView mav = new ModelAndView("index");
		User user = (User)session.getAttribute("loginUser");
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
    }

    @PostMapping("/meetup/register.html")
    public ModelAndView register(Meetup meetup, BindingResult br, HttpSession session, 
                HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView();
        User user = (User)session.getAttribute("loginUser");
        meetup.setW_id(user.getUsername());
        // 기존 모임 등록 로직
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
        mav.addObject("message", "모임이 등록되었습니다.");
        return mav;
    }
    
    @GetMapping(value = "/meetup/detail.html")
    public ModelAndView detail(Integer id, HttpSession session) {
        ModelAndView mav = new ModelAndView("DetailGroup");
        Meetup meetup = this.meetingService.getMeetDetail(id);
        User user = (User)session.getAttribute("loginUser");
		mav.addObject("user", user);
        mav.addObject("meetup", meetup);
        return mav;
    }
}
