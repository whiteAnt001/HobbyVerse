package com.springboot.hobbyverse.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.mapper.MeetingCancelMapper;
import com.springboot.hobbyverse.model.MeetingApply;

@Service
public class MeetingCancelService {
	@Autowired
	private MeetingCancelMapper meetingCancelMapper;
	
	public void MeetingCancel(Integer m_id) {
		this.meetingCancelMapper.MeetingCancel(m_id);
	}
	
	public MeetingApply getM_id(Integer m_id) {
		return this.meetingCancelMapper.getM_id(m_id);
	}
	
	public void outUser(Integer apply_id) {
		this.meetingCancelMapper.outUser(apply_id);
		System.out.println();
	}
}
