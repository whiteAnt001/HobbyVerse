package com.springboot.hobbyverse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.deser.std.UntypedObjectDeserializer.Vanilla;
import com.springboot.hobbyverse.mapper.CategoryMapper;
import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.StartEnd;

@Service
public class CategoryService {
	@Autowired
	private CategoryMapper categoryMapper;
	
	public Integer getKeyCountByName(String title) {
		return this.categoryMapper.getKeyCountByName(title);
	}
	
	public List<Category> getKeyByName(String title, Integer pageNo) {
		if(pageNo == null) pageNo = 1;
		int start = (pageNo - 1) * 6;
		int end = ((pageNo - 1) * 6) + 5;
		StartEnd se = new StartEnd();
		se.setStart(start);
		se.setEnd(end);
		se.setTitle(title);
		return this.categoryMapper.getKeyByName(se);
	}
}
