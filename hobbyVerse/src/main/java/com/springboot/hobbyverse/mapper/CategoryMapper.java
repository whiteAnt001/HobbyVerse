package com.springboot.hobbyverse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.SameMeeting;
import com.springboot.hobbyverse.model.StartEnd;

@Mapper
public interface CategoryMapper {
	List<Meetup> getKeyByName(StartEnd se);//검색 페이지 처리
	Integer getKeyCountByName(SameMeeting sm);//검색 개수
	List<Meetup> getMeet(StartEnd se);//카테고리 별 모임 페이지 처리
	Integer getMeetCount(Integer c_key);//카테고리별 모임 개수
}