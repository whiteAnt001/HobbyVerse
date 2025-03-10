package com.springboot.hobbyverse.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MeetingCancelMapper {
	void MeetingCancel(Integer m_id);
}
