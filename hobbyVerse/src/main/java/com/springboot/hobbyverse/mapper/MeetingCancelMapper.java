package com.springboot.hobbyverse.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.hobbyverse.model.MeetingApply;


@Mapper
public interface MeetingCancelMapper {
	void MeetingCancel(Integer m_id);
	MeetingApply getM_id(Integer m_id);
	void outUser(Integer apply_id);
}
