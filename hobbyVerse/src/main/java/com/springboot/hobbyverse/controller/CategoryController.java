package com.springboot.hobbyverse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.service.CategoryService;

@Controller
public class CategoryController {
	@Autowired
	private CategoryService categoryService;
	
	@GetMapping("/category/key")
	public ModelAndView key() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("keySelect");
		return mav;
	}
	
	@GetMapping("/category/{item}")
	public ModelAndView selectcategory(@PathVariable Integer c_key) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("keyDetail");
		mav.addObject(c_key);
		return mav;
	}
	
	@PostMapping("/category/search")
	public ModelAndView search(String NAME, Integer PAGE_NUM) {
		ModelAndView mav = new ModelAndView();
		int currentPage = 1;
		if(PAGE_NUM != null) currentPage = PAGE_NUM;
		int totalCount = this.categoryService.getKeyCountByName(NAME);
		int pageCount = totalCount / 5;
		if(totalCount % 5 != 0) pageCount++;
		List<Category> keyList = this.categoryService.getKeyByName(NAME, PAGE_NUM);
		mav.addObject("NAME", NAME);
		mav.addObject("pageCount", pageCount);
		mav.setViewName("searchMeetingByName");
		mav.addObject("keyList",keyList);
		return mav;
	}

}
