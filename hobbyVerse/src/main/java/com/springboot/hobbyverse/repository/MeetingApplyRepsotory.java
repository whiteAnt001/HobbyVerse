package com.springboot.hobbyverse.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.springboot.hobbyverse.model.MeetingApply;


public interface MeetingApplyRepsotory extends JpaRepository<MeetingApply, Long>{
	//참가 신청한 모임인지 확인
	boolean existsByIdAndMid(Long user_id, Integer m_id);
	
}
