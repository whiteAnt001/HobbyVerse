package com.springboot.hobbyverse.mapper;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	@GetMapping("/category/sports")
	public ModelAndView sport() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("keyDetail");
		return mav;
	}
	
	@PostMapping("/category/search")
	public ModelAndView search(String NAME, Integer PAGE_NUM) {
		int currentPage = 1;
		if(PAGE_NUM != null) currentPage = PAGE_NUM;
		int start = (currentPage - 1) * 6;
		int end = ((currentPage - 1) * 6) + 7;
		List<Category> keyList = this.categoryService.getKeyByName(NAME, PAGE_NUM);
		Integer totalCount = this.categoryService.getKeyCountByName(NAME);
		int pageCount = totalCount / 5;
		if(totalCount % 5 != 0) pageCount++;
		ModelAndView mav = new ModelAndView();
		mav.addObject("startRow",start); mav.addObject("endRow",end); 
		mav.addObject("total",totalCount); 
		mav.addObject("keyList",keyList);
		mav.addObject("pageCount", pageCount); 
		mav.addObject("currentPage",currentPage);
		mav.setViewName("searchMeetingByName");
		mav.addObject("NAME", NAME);
		return mav;
	}

}
