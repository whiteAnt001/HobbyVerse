package com.springboot.hobbyverse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.Recommend;
import com.springboot.hobbyverse.model.StartEnd;
import com.springboot.hobbyverse.model.User;


@Mapper
public interface MeetingMapper {
   // 조회수 증가
    @Update("UPDATE MEETUP SET VIEWS = VIEWS + 1 WHERE M_ID = #{id}")
    void incrementViews(Integer id);
    // 조회수 가져오기
    @Select("SELECT VIEWS FROM MEETUP WHERE M_ID = #{id}")
    Integer getViews(Integer id);
    
   List<Category> getCategoryList();//카테고리 리스트찾기
   
   void putMeeting(Meetup meetup);//모임 등록   
   
   List<Meetup> getMeetList(StartEnd se);//모임 리스트
   List<Meetup> getMeetings(StartEnd se); //모임 리스트 출력(관리자용)
   
   Integer getTotal();//모임 전체 갯수
   Integer getMaxId();//모임 번호 찾기
   Meetup getMeetingById(Integer id);
   Meetup getMeetDetail(Integer id);//m_id로 모임상세 찾기
   
   //title로 모임 검색
   List<Meetup> getMeetByTitle(StartEnd se);//모임 상세검색
   Integer getMeetCountByTitle(String title);//모임 갯수 검색
   
   List<Meetup> getMeetingByUser(String email); // 특정 유저가 만든 모임 찾기
   
   Integer deleteById(Integer id); //m_id로 게시글 삭제
   void updateMeeting(Meetup meetup);//모임수정
   
   List<Recommend> getRecommend(Recommend recommend);//추천 확인
   void putRecommend(int m_id, String email);//추천하기
   Integer getRecommendCheck(Integer m_id, String email);//중복추천 방지
   Meetup getMeet(Integer m_id);// 모임 아이디로 모임 찾기
   Meetup getMeetTitle(Integer m_id);//모임 아이디로 모임 이름 찾기
   String getW_id(Integer m_id);//모임 아이디로 주뢰자 가져오기
}
