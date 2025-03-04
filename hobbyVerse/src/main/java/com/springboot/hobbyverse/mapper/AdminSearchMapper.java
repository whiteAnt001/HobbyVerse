package com.springboot.hobbyverse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.StartEnd;
import com.springboot.hobbyverse.model.User;

@Mapper
public interface AdminSearchMapper {
	List<Meetup> searchMeet(StartEnd se);//모임 검색 ( 관리자 계정 )
	Integer searchMeetCount(String title);//검색 모임 개수 ( 관리자 계정 )
	List<User> searchUser(StartEnd se);//회원 검색 ( 관리자 계정 )
	Integer searchUserCount(String email);//검색 회원수 ( 관리자 계정 )
	
}
