package com.springboot.hobbyverse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.hobbyverse.model.Notice;

@Mapper
public interface NoticeMapper {
	List<Notice> getNoticeList();
	void putNotice(Notice notice);
}
