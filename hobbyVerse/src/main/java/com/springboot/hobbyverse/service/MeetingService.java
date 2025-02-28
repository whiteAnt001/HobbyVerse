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
	public List<Meetup> getMeetList(Integer pageNo) {
		if(pageNo == null) pageNo = 1;
		int start = (pageNo - 1) * 6;
		int end = ((pageNo - 1) * 6) + 7;
		StartEnd se = new StartEnd();
		se.setStart(start); se.setEnd(end);
	    return this.meetingMapper.getMeetList(se);
	}
	public Integer getTotal() {
		return this.meetingMapper.getTotal();
	}
	public Integer getMaxId() {
		Integer max = meetingMapper.getMaxId();
		if(max == null) return 0;
		return max;
	}
	public Meetup getMeetDetail(Integer id) {
	    return meetingMapper.getMeetDetail(id); //모임상세
	}
	
	public List<Meetup> getMeetingByUser(String email) {
		return this.meetingMapper.getMeetingByUser(email);
	}
	
	public Integer deleteById(Integer id) {
		return this.meetingMapper.deleteById(id);
	}
	public void updateMeeting(Meetup meetup) {
		this.meetingMapper.updateMeeting(meetup);
	}
	
	//모임 아이디로 모임 찾기
	public Meetup getMeet(Integer m_id) {
		return this.meetingMapper.getMeet(m_id);
	}
	public Meetup getMeetingById(Integer id) {
		return this.meetingMapper.getMeetingById(id);
	}
	
	public List<Meetup> getMeetings(){
		return this.meetingMapper.getMeetings();
	}

}
