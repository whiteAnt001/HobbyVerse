package com.springboot.hobbyverse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.service.CategoryService;
import com.springboot.hobbyverse.service.MeetingService;
import com.springboot.hobbyverse.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class CategoryController {
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private UserService userService;
	@Autowired
	private MeetingService meetingService;
	
	@GetMapping("/category/key")//카테고리 버튼 선택
	public ModelAndView key(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser");
		mav.addObject("user", user);
		mav.setViewName("keySelect");
		return mav;
	}
	
	//스포츠 모임
	@GetMapping("/category/moveSport")//카테고리 필터 선택
	public ModelAndView getSport(Integer pageNo, Integer c_key, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser");
		int currentPage = 1;
		if(pageNo != null) currentPage = pageNo;
		c_key = 1;
		List<Meetup> keyCategory = this.categoryService.getMeet(pageNo, c_key);
		int totalCount = this.categoryService.getMeetCount(c_key);
		int pageCount = totalCount / 6;
		if(totalCount % 6 != 0) pageCount++;
		session.setAttribute("c_key", c_key);
		mav.addObject("user", user);
		mav.addObject("keyCategory", keyCategory);
		mav.addObject("pageCount", pageCount);
		mav.addObject("currentPage", currentPage);
		mav.setViewName("keyDetailSport");
		return mav;
	}

	//음악 모임
	@GetMapping("/category/moveMusic")//카테고리 필터 선택
	public ModelAndView getMusic(Integer pageNo, Integer c_key, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser");
		int currentPage = 1;
		if(pageNo != null) currentPage = pageNo;
		c_key = 2;
		List<Meetup> keyCategory = this.categoryService.getMeet(pageNo, c_key);
		int totalCount = this.categoryService.getMeetCount(c_key);
		int pageCount = totalCount / 6;
		if(totalCount % 6 != 0) pageCount++;
		session.setAttribute("c_key", c_key);
		mav.addObject("user", user);
		mav.addObject("keyCategory", keyCategory);
		mav.addObject("pageCount", pageCount);
		mav.addObject("currentPage", currentPage);
		mav.setViewName("keyDetailMusic");
		return mav;
	}
	
	//스터디 모임
	@GetMapping("/category/moveStudy")//카테고리 필터 선택
	public ModelAndView getStudy(Integer pageNo, Integer c_key, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser");
		int currentPage = 1;
		if(pageNo != null) currentPage = pageNo;
		c_key = 3;
		List<Meetup> keyCategory = this.categoryService.getMeet(pageNo, c_key);
		int totalCount = this.categoryService.getMeetCount(c_key);
		int pageCount = totalCount / 6;
		if(totalCount % 6 != 0) pageCount++;
		session.setAttribute("c_key", c_key);
		mav.addObject("user", user);
		mav.addObject("keyCategory", keyCategory);
		mav.addObject("pageCount", pageCount);
		mav.addObject("currentPage", currentPage);
		mav.setViewName("keyDetailStudy");
		return mav;
	}
	
	//게임 모임
	@GetMapping("/category/moveGame")//카테고리 필터 선택
	public ModelAndView getGame(Integer pageNo, Integer c_key, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser");
		int currentPage = 1;
		if(pageNo != null) currentPage = pageNo;
		c_key = 4;
		List<Meetup> keyCategory = this.categoryService.getMeet(pageNo, c_key);
		int totalCount = this.categoryService.getMeetCount(c_key);
		int pageCount = totalCount / 6;
		if(totalCount % 6 != 0) pageCount++;
		session.setAttribute("c_key", c_key);
		mav.addObject("user", user);
		mav.addObject("keyCategory", keyCategory);
		mav.addObject("pageCount", pageCount);
		mav.addObject("currentPage", currentPage);
		mav.setViewName("keyDetailGame");
		return mav;
	}
	
	//여행 모임
	@GetMapping("/category/moveTravel")//카테고리 필터 선택
	public ModelAndView getTravel(Integer pageNo, Integer c_key, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser");
		int currentPage = 1;
		if(pageNo != null) currentPage = pageNo;
		c_key = 5;
		List<Meetup> keyCategory = this.categoryService.getMeet(pageNo, c_key);
		int totalCount = this.categoryService.getMeetCount(c_key);
		int pageCount = totalCount / 6;
		if(totalCount % 6 != 0) pageCount++;
		session.setAttribute("c_key", c_key);
		mav.addObject("user", user);
		mav.addObject("keyCategory", keyCategory);
		mav.addObject("pageCount", pageCount);
		mav.addObject("currentPage", currentPage);
		mav.setViewName("keyDetailTravel");
		return mav;
	}
	
	//기타 
	@GetMapping("/category/moveEtc")//카테고리 필터 선택
	public ModelAndView getEtc(Integer pageNo, Integer c_key, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("loginUser");
		int currentPage = 1;
		if(pageNo != null) currentPage = pageNo;
		c_key = 6;
		List<Meetup> keyCategory = this.categoryService.getMeet(pageNo, c_key);
		int totalCount = this.categoryService.getMeetCount(c_key);
		int pageCount = totalCount / 6;
		if(totalCount % 6 != 0) pageCount++;
		session.setAttribute("c_key", c_key);
		mav.addObject("user", user);
		mav.addObject("keyCategory", keyCategory);
		mav.addObject("pageCount", pageCount);
		mav.addObject("currentPage", currentPage);
		mav.setViewName("keyDetailEtc");
		return mav;
	}
	
	
    @PostMapping("/category/search") // 모임 이름으로 모임 검색
    public ModelAndView searchPOST(String NAME, Integer pageNo, Integer KEY, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        User user = (User)session.getAttribute("loginUser");
        int currentPage = 1;
        if (pageNo != null) currentPage = pageNo;
        session.setAttribute("name", NAME);
        KEY = (Integer)session.getAttribute("c_key");
        List<Meetup> keyList = this.categoryService.getKeyByName(NAME, pageNo, KEY);
        int totalCount = this.categoryService.getKeyCountByName(NAME, KEY);
        int pageCount = totalCount / 6;
        if (totalCount % 6 != 0) pageCount++;
        mav.addObject("keyList", keyList);
        mav.addObject("user", user);
        mav.addObject("NAME", NAME);
        mav.addObject("KEY", KEY);
        mav.addObject("pageCount", pageCount);
        mav.addObject("currentPage", currentPage);
        mav.setViewName("searchMeetingByName");
        return mav;
    }
    
    @GetMapping("/category/search") // 모임 이름으로 모임 검색
    public ModelAndView searchGET(String NAME, Integer pageNo, Integer KEY, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        User user = (User)session.getAttribute("loginUser");
        int currentPage = 1;
        if (pageNo != null) currentPage = pageNo;
        NAME = (String)session.getAttribute("name"); 
        KEY = (Integer)session.getAttribute("c_key");
        List<Meetup> keyList = this.categoryService.getKeyByName(NAME, pageNo, KEY);
        int totalCount = this.categoryService.getKeyCountByName(NAME, KEY);
        int pageCount = totalCount / 6;
        if (totalCount % 6 != 0) pageCount++;
        mav.addObject("keyList", keyList);
        mav.addObject("user", user);
        mav.addObject("NAME", NAME);
        mav.addObject("KEY", KEY);
        mav.addObject("pageCount", pageCount);
        mav.addObject("currentPage", currentPage);
        mav.setViewName("searchMeetingByName");
        return mav;
    }


}