//package com.springboot.hobbyverse.controller;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.servlet.ModelAndView;
//
//import com.springboot.hobbyverse.model.User;
//import com.springboot.hobbyverse.service.UserService;
//
//import jakarta.servlet.http.HttpSession;
//import lombok.RequiredArgsConstructor;
//
//@RequiredArgsConstructor
//@Controller
//public class ViewController {
//	@Autowired
//	private UserService userService;
//	
//	@GetMapping("/home")
//	public ModelAndView getHome(HttpSession session) {
//		ModelAndView mav = new ModelAndView("index");
//		User user = (User)session.getAttribute("loginUser");
//		mav.addObject("user", user);
//		return mav;
//	}
//}
package com.springboot.hobbyverse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.StartEnd;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.service.MeetingService;
import com.springboot.hobbyverse.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class ViewController {

    @Autowired 
    private MeetingService meetingService;
	
	@GetMapping("/home")
	public ModelAndView getHome(Integer PAGE_NUM, HttpSession session) {
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
}
