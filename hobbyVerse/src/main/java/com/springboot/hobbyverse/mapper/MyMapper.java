package com.springboot.hobbyverse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.hobbyverse.model.Board;
import com.springboot.hobbyverse.model.MeetingApply;
import com.springboot.hobbyverse.model.StartEnd;
import com.springboot.hobbyverse.model.User;


@Mapper
public interface MyMapper {
	User getUser(User user); // 회원가입시 사용하는 메서드
	List<User> getUserList(StartEnd se); // 모든 유저를 찾는 메서드
	Integer getUserCount(); // 총 유저수를 찾는 메서드
	List<Board> getMyPost(String email);
	User getUserInfo(Long id);//계정으로 유저 정보 가져오는 매퍼
	List<MeetingApply> meetingList(Long user_id);
}
