package com.springboot.hobbyverse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.hobbyverse.model.MeetingApply;


@Mapper
public interface MeetingApplyMapper {
//	//참가 정보 추가
//	void insertMeetInfo(MeetingApply meetingApply);
	List<MeetingApply> joinedUser(Integer m_id);
}
