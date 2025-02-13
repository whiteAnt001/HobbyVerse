package com.springboot.hobbyverse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.StartEnd;


@Mapper
public interface MeetingMapper {
	void putMeeting(Meetup meetup);//모임 등록	
	List<Category> getCategoryList();//카테고리 리스트찾기
	List<Meetup> getMeetList(StartEnd se);//모임 리스트
	Integer getTotal();//모임 전체 갯수
	Integer getMaxId();
	Meetup getMeetDetail(Integer id);//id로 모임상세 찾기
}
