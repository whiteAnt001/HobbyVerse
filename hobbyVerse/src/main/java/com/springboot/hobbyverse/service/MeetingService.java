package com.springboot.hobbyverse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.mapper.MeetingMapper;
import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.StartEnd;

@Service
public class MeetingService {
	@Autowired
	private MeetingMapper meetingMapper;
	
	public List<Category> getCategoryList(){//카테고리 목록
		return this.meetingMapper.getCategoryList();
	}
	
	public void putMeeting(Meetup meetup) {//모임 등록
		meetup.setM_id(this.getMaxId() + 1);
		this.meetingMapper.putMeeting(meetup);
	}
	public List<Meetup> getMeetList(Integer pageNo) {//모임목록,페이지처리
		if(pageNo == null) pageNo = 1;
		int start = (pageNo - 1) * 6;
		int end = ((pageNo - 1) * 6) + 7;
		StartEnd se = new StartEnd();
		se.setStart(start); se.setEnd(end);
	    return this.meetingMapper.getMeetList(se);
	}
	public Integer getTotal() {//모임 전체갯수
		return this.meetingMapper.getTotal();
	}
	public Integer getMaxId() {//모임번호
		Integer max = meetingMapper.getMaxId();
		if(max == null) return 0;
		return max;
	}
	public Meetup getMeetDetail(Integer id) {
	    return meetingMapper.getMeetDetail(id); //모임상세
	}
	
	//모임제목으로 모임 검색
	public List<Meetup> getMeetByTitle(String title, Integer pageNo){
		if(pageNo == null) pageNo = 1;
	    int start = (pageNo - 1) * 6;
	    int end = start + 7;
	    StartEnd se = new StartEnd();
	    se.setStart(start); se.setEnd(end); se.setTitle(title);
	    return this.meetingMapper.getMeetByTitle(se);
	}//모임 상세 검색
	public Integer getMeetCountByTitle(String title) {
		return this.meetingMapper.getMeetCountByTitle(title);
	}//모임 갯수 검색
	
	//모임 삭제 수정
	public void deleteMeeting(Integer m_id) {
		this.meetingMapper.deleteById(m_id);
	}
	public void updateMeeting(Meetup meetup) {
		this.meetingMapper.updateMeeting(meetup);
	}
	public List<Meetup> getMeetingByUser(String email){
		return this.meetingMapper.getMeetingByUser(email);
	}
	public Integer deleteById(Integer id) {
		return this.meetingMapper.deleteById(id);
	}
	public List<Meetup> getMeetings(){
		return this.meetingMapper.getMeetings();
	}
}
