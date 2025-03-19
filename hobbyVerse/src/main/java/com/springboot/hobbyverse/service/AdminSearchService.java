package com.springboot.hobbyverse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.mapper.AdminSearchMapper;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.StartEnd;
import com.springboot.hobbyverse.model.User;

import jakarta.validation.constraints.Email;

@Service
public class AdminSearchService {
	@Autowired
	private AdminSearchMapper adminSearchMapper;

	// 관리자 계정 - 모임 검색
	public List<Meetup> searchMeet(String title, Integer pageNo) {
		if (pageNo == null)
			pageNo = 1;
		int start = (pageNo - 1) * 6;
		int end = ((pageNo - 1) * 6) + 7;
		StartEnd se = new StartEnd();
		se.setStart(start);
		se.setEnd(end);
		se.setTitle(title);
		return this.adminSearchMapper.searchMeet(se);
	}

	public Integer searchMeetCount(String title) {
		return this.adminSearchMapper.searchMeetCount(title);
	}

	//관리자 계정 - 유저 검색
	public List<User> searchUser(String search, Integer pageNo) {
		if (pageNo == null)
			pageNo = 1;
		int start = (pageNo - 1) * 6;
		int end = ((pageNo - 1) * 6) + 7;
		StartEnd se = new StartEnd();
		se.setStart(start);
		se.setEnd(end);
		se.setSearch(search);
		//System.out.println("email:" + se.getEmail() + ",name:" + se.getEmail());
		return this.adminSearchMapper.searchUser(se);
	}

	public Integer searchUserCount(String search) {
		return this.adminSearchMapper.searchUserCount(search);
	}
}
