package com.springboot.hobbyverse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.mapper.MeetingMapper;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.StartEnd;


@Service
public class MeetingService {
	@Autowired
	private MeetingMapper meetingMapper;
	
	public void putMeeting(Meetup meetup) {//모임 등록
		this.meetingMapper.putMeeting(meetup);
	}
	public List<Object[]> getCategoryList(){//카테고리
		return this.meetingMapper.getCategoryList();
	}
	public List<Meetup> getMeetList(){//모임 리스트
		return this.meetingMapper.getMeetList();
	}
	public Meetup getMeetDetail(Integer id) {//모임 상세
		return this.meetingMapper.getMeetDetail(id);
		meetup.setM_id(this.getMaxId() + 1);
		this.meetingMapper.putMeeting(meetup);
	}
	public List<Meetup> getMeetList(Integer pageNo) {
		if(pageNo == null) pageNo = 1;
		int start = (pageNo - 1) * 6;
		int end = ((pageNo - 1) * 6) + 6;
		StartEnd se = new StartEnd();
		se.setStart(start); se.setEnd(end);
	    return this.meetingMapper.getMeetList(se);
	}

	public Integer getTotal() {
		return this.meetingMapper.getTotal();
	}
	
	public List<Category> getCategoryList(){//카테고리 목록
		return this.meetingMapper.getCategoryList();
	}
	public Integer getMaxId() {
		Integer max = meetingMapper.getMaxId();
		if(max == null) return 0;
		return max;
	}
	public Meetup getMeetDetail(Integer id) {
	    return meetingMapper.getMeetDetail(id); //모임상세
	}
}
