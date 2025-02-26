package com.springboot.hobbyverse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.mapper.MeetingMapper;
import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.Recommend;
import com.springboot.hobbyverse.model.StartEnd;


@Service
public class MeetingService {
	@Autowired
	private MeetingMapper meetingMapper;
	
	public List<Category> getCategoryList(){//카테고리 목록
		return this.meetingMapper.getCategoryList();
	}
	
	public void putMeeting(Meetup meetup) {//모임 등록
		meetup.setM_id(this.getMaxId() + 1);
		this.meetingMapper.putMeeting(meetup);
	}
	public List<Meetup> getMeetList(Integer pageNo) {//모임 목록
		if(pageNo == null) pageNo = 1;
		int start = (pageNo - 1) * 6;
		int end = ((pageNo - 1) * 6) + 7;
		StartEnd se = new StartEnd();
		se.setStart(start); se.setEnd(end);
	    return this.meetingMapper.getMeetList(se);
	}
	public Integer getTotal() {//모임 총갯수
		return this.meetingMapper.getTotal();
	}
	public Integer getMaxId() {//모임번호
		Integer max = meetingMapper.getMaxId();
		if(max == null) return 0;
		return max;
	}
	public Meetup getMeetDetail(Integer id) {
	    return meetingMapper.getMeetDetail(id); //모임상세
	}
	
	public void updateMeeting(Meetup meetup) {//모임 수정
		this.meetingMapper.updateMeeting(meetup);
	}
	public Integer deleteById(Integer id) {
		return this.meetingMapper.deleteById(id);
	}
	
	public List<Meetup> getMeetingByUser(String email){
		return this.meetingMapper.getMeetingByUser(email);
	}
	
	public List<Meetup> getMeetings(){
	    return this.meetingMapper.getMeetings();
	}
	public Meetup getMeetingById(Integer id) {
	    return this.meetingMapper.getMeetingById(id);
	}
	
	//모임제목으로 모임 검색
	public List<Meetup> getMeetByTitle(String title, Integer pageNo){
		if(pageNo == null) pageNo = 1;
	    int start = (pageNo - 1) * 6;
	    int end = start + 7;
	    StartEnd se = new StartEnd();
	    se.setStart(start); se.setEnd(end); se.setTitle(title);
	    return this.meetingMapper.getMeetByTitle(se);
	}//모임 상세 검색
	public Integer getMeetCountByTitle(String title) {
		return this.meetingMapper.getMeetCountByTitle(title);
	}//모임 갯수 검색

	//추천
	public List<Recommend> getRecommend(Recommend recommend){
		return this.meetingMapper.getRecommend(recommend);
	}//추천 확인
	public void putRecommend(int m_id, String email) {
		this.meetingMapper.putRecommend(m_id, email);
	}//추천하기
	public Integer getRecommendCheck(Integer m_id, String email) {
		return this.meetingMapper.getRecommendCheck(m_id,email);
	}
	
	//찜
	
	// 조회수 가져오기
	public Integer getViews(Integer id) {
		return meetingMapper.getViews(id);
	}
	// 조회수 증가 메서드 추가
	public void incrementViews(Integer id) {
		if (id == null) {
		    System.out.println("🚨 ERROR: ID is null in incrementViews()");
		    return;
		}       
	   this.meetingMapper.incrementViews(id);
	}
	// 조회수 가져오기
	public Integer getViews(Integer id) {
	    return meetingMapper.getViews(id);
	}
	// 조회수 증가 메서드 추가
	public void incrementViews(Integer id) {
	    if (id == null) {
	        System.out.println("🚨 ERROR: ID is null in incrementViews()");
	        return;
	    }	    
	    this.meetingMapper.incrementViews(id);
	}
}
