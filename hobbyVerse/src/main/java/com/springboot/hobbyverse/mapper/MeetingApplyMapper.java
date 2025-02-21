package com.springboot.hobbyverse.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.hobbyverse.model.MeetingApply;


@Mapper
public interface MeetingApplyMapper {
	//참가 정보 추가
	void insertMeetInfo(MeetingApply meetingApply);
}
