package com.springboot.hobbyverse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.Report;
import com.springboot.hobbyverse.model.StartEnd;

@Mapper
public interface ReportMapper {   
	void putReport(Report report);// 신고 추가  
	List<Report> getReportList(StartEnd se);// 모든 신고 목록 가져오기   
	Integer getReportCountById(Integer m_id);// 특정 모임 ID에 대한 신고 횟수 찾기  
	Integer getReportTotal();// 신고된 모임 총 개수  
	List<Meetup> getReportedMeeting();// 신고된 모임 목록과 각 모임별 신고 횟수
	Report getReportDetail(Integer report_id);//신고 상세정보
	List<Meetup> getMeetingList();//모임목록
	void deleteReports(Integer report_id);//신고 삭제
	List<Report> getReportByTitle(StartEnd se);//모임 제목으로 신고목록 검색
	Integer getReportCountByTitle(String title);//모임제목으로 모임갯수 검색
}
