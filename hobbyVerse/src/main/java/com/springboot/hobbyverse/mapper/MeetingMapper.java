package com.springboot.hobbyverse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.StartEnd;

@Mapper
public interface MeetingMapper {
	List<Category> getCategoryList();// 카테고리 리스트찾기
//  Category getCategoryByName(String name);//카테고리 이름찾기
	void putMeeting(Meetup meetup);// 모임 등록
	List<Meetup> getMeetList(StartEnd se);// 모임 리스트
	List<Meetup> getMeetings(); // 모임 리스트 출력(관리자용)
	Integer getTotal();// 모임 전체 갯수
	Integer getMaxId();
	Meetup getMeetingById(Integer id);
	Meetup getMeetDetail(Integer id);//id로 모임상세 찾기
	List<Meetup> getMeetingByUser(String email); // 특정 유저가 만든 모임 찾기
	Integer deleteById(Integer id); //m_id로 게시글 삭제
	void updateMeeting(Meetup meetup);//모임수정
	
	// 조회수 증가
    @Update("UPDATE MEETUP SET VIEWS = VIEWS + 1 WHERE M_ID = #{id}")
    void incrementViews(Integer id);

    // 조회수 가져오기
    @Select("SELECT VIEWS FROM MEETUP WHERE M_ID = #{id}")
    Integer getViews(Integer id);
	Integer deleteById(Integer id); // m_id로 게시글 삭제
	void updateMeeting(Meetup meetup);// 모임수정
	Meetup getMeet(Integer m_id);// 모임 아이디로 모임 찾기
}
