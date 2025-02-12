package com.springboot.hobbyverse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.deser.std.UntypedObjectDeserializer.Vanilla;
import com.springboot.hobbyverse.mapper.CategoryMapper;
import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.SameMeeting;
import com.springboot.hobbyverse.model.StartEnd;

@Service
public class CategoryService {
	@Autowired
	private CategoryMapper categoryMapper;
	
	public List<Meetup> getKeyByName(String title, Integer pageNo, Integer key) {
		if(pageNo == null) pageNo = 1;
		int start = (pageNo - 1) * 6;
		int end = ((pageNo - 1) * 6) + 5;
		StartEnd se = new StartEnd();
		se.setStart(start);
		se.setEnd(end);
		se.setTitle(title);
		se.setC_key(key);
		return this.categoryMapper.getKeyByName(se);
	}
	
	public Integer getKeyCountByName(String title, Integer c_key) {
		SameMeeting sm = new SameMeeting();
		sm.setTitle(title);
		sm.setC_key(c_key);
		return this.categoryMapper.getKeyCountByName(sm);
	}
	
	public List<Meetup> getMeet(Integer c_key) {
		return this.categoryMapper.getMeet(c_key);
	}

}
