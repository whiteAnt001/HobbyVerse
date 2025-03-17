package com.springboot.hobbyverse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.mapper.ReportMapper;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.Report;
import com.springboot.hobbyverse.model.StartEnd;

@Service
public class ReportService { 
	@Autowired
	private ReportMapper reportMapper;
	
	public void putReport(Report report) {
		this.reportMapper.putReport(report);
	}// 신고 추가    
	
	public List<Report> getReportList(Integer pageNo) {
	    if (pageNo == null) pageNo = 1;
	    int start = (pageNo - 1) * 10;
	    int end = start + 11;
	    StartEnd se = new StartEnd();
	    se.setStart(start); 
	    se.setEnd(end);
	    return this.reportMapper.getReportList(se);
	}// 모든 신고 목록 가져오기  
	 
	
	public Integer getReportTotal() {
	    return this.reportMapper.getReportTotal();
	}// 신고된 모임 총 개수
	
	public List<Meetup> getReportedMeeting() {
	    return this.reportMapper.getReportedMeeting();
	}// 신고된 모임 목록과 신고 횟수
	
	public Report getReportDetail(Integer report_id) {
		return this.reportMapper.getReportDetail(report_id);
	}//신고된 모임 상세정보
	
	public List<Meetup> getMeetingList(){
		return this.reportMapper.getMeetingList();
	}//모임목록
	
	public void deleteReports(Integer report_id) {
		this.reportMapper.deleteReports(report_id);
	}//신고모임 삭제
	
	public List<Report> getReportByTitle(String title, Integer pageNo){
		if (pageNo == null) pageNo = 1;
	    int start = (pageNo - 1) * 10;
	    int end = start + 11;
	    StartEnd se = new StartEnd();
	    se.setStart(start); se.setEnd(end); se.setTitle(title);
		return this.reportMapper.getReportByTitle(se);
	}
	public Integer getReportCountByTitle(String title) {
		return this.reportMapper.getReportCountByTitle(title);
	}
}
