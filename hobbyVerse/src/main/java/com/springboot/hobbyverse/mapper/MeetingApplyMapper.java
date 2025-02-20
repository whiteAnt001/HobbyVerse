package com.springboot.hobbyverse.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.hobbyverse.model.MeetingApply;


@Mapper
public interface MeetingApplyMapper {
	public MeetingApply findByMeetingId(Integer m_id);
}
