package com.springboot.hobbyverse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.hobbyverse.model.Meetup;


@Mapper
public interface MeetingMapper {
	void putMeeting(Meetup meetup);//모임 등록	
	List<Object[]> getCategoryList();//카테고리 리스트찾기
	List<Meetup> getMeetList();//모임 리스트
	Meetup getMeetDetail(Integer id);//id로 모임상세 찾기
}
