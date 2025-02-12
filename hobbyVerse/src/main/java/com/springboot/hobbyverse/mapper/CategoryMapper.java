package com.springboot.hobbyverse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.SameMeeting;
import com.springboot.hobbyverse.model.StartEnd;

@Mapper
public interface CategoryMapper {
	List<Meetup> getKeyByName(StartEnd se);
	Integer getKeyCountByName(SameMeeting sm);
	List<Meetup> getMeet(Integer c_key);
}
