package com.springboot.hobbyverse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.mapper.MyMapper;
import com.springboot.hobbyverse.model.Board;
import com.springboot.hobbyverse.model.MeetingApply;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.repository.BoardRepository;
import com.springboot.hobbyverse.repository.UserRepository;

@Service
public class MyPageService {
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private MeetingService meetingService;
	@Autowired
	private BoardRepository boardRepository;
	@Autowired
	private MyMapper myMapper;
	
	public User getUserInfo(String email) {
		User user = userRepository.findByEmail(email);
		 if(user == null) {
			 throw new RuntimeException("사용자를 찾을 수 없습니다.");
		 }
		 return user;
	}
	
	//내가 만든 모임 조회
	public List<Meetup> getCreateMeetings(String email){
		return meetingService.getMeetingByUser(email);
	}
	
	//참여신청한 모임 아이디로 검색
	public List<MeetingApply> meetingList(Long user_id) {
		return this.myMapper.meetingList(user_id);
	}
}
