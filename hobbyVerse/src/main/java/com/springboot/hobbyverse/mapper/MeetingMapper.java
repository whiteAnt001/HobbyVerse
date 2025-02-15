package com.springboot.hobbyverse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.StartEnd;


@Mapper
public interface MeetingMapper {
	List<Category> getCategoryList();//카테고리 리스트찾기
//	Category getCategoryByName(String name);//카테고리 이름찾기
	
	void putMeeting(Meetup meetup);//모임 등록	
	List<Meetup> getMeetList(StartEnd se);//모임 리스트
	List<Meetup> getMeetings(); //모임 리스트 출력(관리자용)
	Integer getTotal();//모임 전체 갯수
	Integer getMaxId();
	Meetup getMeetDetail(Integer id);//m_id로 모임상세 찾기
	
	void deleteMeeting(Integer m_id);//m_id로 모임삭제
	void updateMeeting(Meetup meetup);//모임수정
}
