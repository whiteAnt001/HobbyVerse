package com.springboot.hobbyverse.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.mapper.MeetingCancelMapper;

@Service
public class MeetingCancelService {
	@Autowired
	private MeetingCancelMapper meetingCancelMapper;
	
	public void MeetingCancel(Integer m_id) {
		this.meetingCancelMapper.MeetingCancel(m_id);
	}
}
