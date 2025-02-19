package com.springboot.hobbyverse.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.mapper.MeetingApplyMapper;
import com.springboot.hobbyverse.model.MeetingApply;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
@Transactional
@Service
public class MeetingApplyService {
	@Autowired
	private MeetingApplyMapper meetingApplyMapper;
	@PersistenceContext
	private EntityManager entityManager;
	
	public MeetingApply findByMeetingId(Integer m_id) {
		return this.meetingApplyMapper.findByMeetingId(m_id);
	}
	public void save(MeetingApply meetingApply) {
//		 if (meetingApply.getApply_id() == null) {
//	            meetingApply.setApply_id(1); // 적절한 값을 설정
//	        }
		 entityManager.persist(meetingApply); // DB에 MeetingApply 객체 저장
    }
	
}
