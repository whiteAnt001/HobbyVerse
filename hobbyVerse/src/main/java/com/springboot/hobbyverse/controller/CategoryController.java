package com.springboot.hobbyverse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.service.CategoryService;

import jakarta.servlet.http.HttpSession;

@Controller
public class CategoryController {
	@Autowired
	private CategoryService categoryService;
	
	@GetMapping("/category/key")//카테고리 버튼 선택
	public ModelAndView key() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("keySelect");
		return mav;
	}
	
	//스포츠 모임
	@GetMapping("/category/moveSport")//카테고리 필터 선택
	public ModelAndView getSport(Integer c_key, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		c_key = 1;
		List<Meetup> keyCategory = this.categoryService.getMeet(c_key);
		session.setAttribute("c_key", c_key);
		mav.setViewName("keyDetailSport");
		mav.addObject("keyCategory", keyCategory);
		return mav;
	}

	//음악 모임
	@GetMapping("/category/moveMusic")//카테고리 필터 선택
	public ModelAndView getMusic(Integer c_key, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		c_key = 2;
		List<Meetup> keyCategory = this.categoryService.getMeet(c_key);
		session.setAttribute("c_key", c_key);
		mav.setViewName("keyDetailMusic");
		mav.addObject("keyCategory", keyCategory);
		return mav;
	}
	
	//스터디 모임
	@GetMapping("/category/moveStudy")//카테고리 필터 선택
	public ModelAndView getStudy(Integer c_key, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		c_key = 3;
		List<Meetup> keyCategory = this.categoryService.getMeet(c_key);
		session.setAttribute("c_key", c_key);
		mav.setViewName("keyDetailStudy");
		mav.addObject("keyCategory", keyCategory);
		return mav;
	}
	
	//게임 모임
	@GetMapping("/category/moveGame")//카테고리 필터 선택
	public ModelAndView getGame(Integer c_key, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		c_key = 4;
		List<Meetup> keyCategory = this.categoryService.getMeet(c_key);
		session.setAttribute("c_key", c_key);
		mav.setViewName("keyDetailGame");
		mav.addObject("keyCategory", keyCategory);
		return mav;
	}
	
	//여행 모임
	@GetMapping("/category/moveTravel")//카테고리 필터 선택
	public ModelAndView getTravel(Integer c_key, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		c_key = 5;
		List<Meetup> keyCategory = this.categoryService.getMeet(c_key);
		session.setAttribute("c_key", c_key);
		mav.setViewName("keyDetailTravel");
		mav.addObject("keyCategory", keyCategory);
		return mav;
	}
	
	//기타 
	@GetMapping("/category/moveEtc")//카테고리 필터 선택
	public ModelAndView getEtc(Integer c_key, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		c_key = 6;
		List<Meetup> keyCategory = this.categoryService.getMeet(c_key);
		session.setAttribute("c_key", c_key);
		mav.setViewName("keyDetailEtc");
		mav.addObject("keyCategory", keyCategory);
		return mav;
	}
	
	
    @PostMapping("/category/search") // 모임 이름으로 모임 검색
    public ModelAndView search(String NAME, Integer PAGE_NUM, Integer KEY, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        int currentPage = 1;
        if (PAGE_NUM != null) currentPage = PAGE_NUM;
        int totalCount = this.categoryService.getKeyCountByName(NAME, KEY);
        int pageCount = totalCount / 6;
        if (totalCount % 6 != 0) pageCount++;
        KEY = (Integer)session.getAttribute("c_key");
        List<Meetup> keyList = this.categoryService.getKeyByName(NAME, PAGE_NUM, KEY);
        mav.addObject("NAME", NAME);
        mav.addObject("KEY", KEY);
        mav.addObject("keyList", keyList);
        System.out.println(keyList);
        mav.addObject("pageCount", pageCount);
        mav.addObject("currentPage", currentPage);
        mav.setViewName("searchMeetingByName");
        return mav;
    }

}
