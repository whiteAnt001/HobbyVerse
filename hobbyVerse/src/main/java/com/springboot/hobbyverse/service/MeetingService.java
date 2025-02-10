package com.springboot.hobbyverse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.mapper.MeetingMapper;
import com.springboot.hobbyverse.model.Meetup;


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
	}
}
