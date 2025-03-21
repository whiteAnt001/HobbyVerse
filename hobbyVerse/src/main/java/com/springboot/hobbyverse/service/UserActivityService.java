package com.springboot.hobbyverse.service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.model.UserActivity;
import com.springboot.hobbyverse.repository.UserActivityRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserActivityService {
	
	private final UserActivityRepository userActivityRepository;
	
	//특정 날짜의 유저 활동 조회
	public List<UserActivity> getUserActivityByDate(LocalDate date){
		return this.userActivityRepository.findByActivityDate(date);
	}
	
	// 최근 7일간의 유저 활동 조회
	public String getRecentUserStats() {
	    LocalDate endDate = LocalDate.now(); // 오늘 날짜
	    LocalDate startDate = endDate.minusDays(7); // 최근 7일

	    // 최근 7일간의 유저 활동 조회
	    List<UserActivity> userStats = userActivityRepository.findByActivityDateBetween(startDate, endDate);

	    // 각 항목별 값 합산
	    int totalNewUsers = userStats.stream().mapToInt(UserActivity::getNewUsers).sum();
	    int totalUnsubscribedUsers = userStats.stream().mapToInt(UserActivity::getUnsubscribedUsers).sum();
	    int totalJoinedMeetings = userStats.stream().mapToInt(UserActivity::getJoinedMeetings).sum();

	    // 결과를 각 항목별 문자열로 반환
	    String userStatsSummary = "<Strong>신규 가입자:</Strong> " + totalNewUsers + "명<br/><br/>"
	            + "<Strong>탈퇴한 사용자:</Strong> " + totalUnsubscribedUsers + "명<br/><br/>"
	            + "<Strong>모임을 가입한 사용자:</Strong> " + totalJoinedMeetings + "명";

	    return userStatsSummary;
	}
	
	//유저 동향 저장
	@Transactional
	public UserActivity saveUserActivity(UserActivity userActivity) {
		return userActivityRepository.save(userActivity);
	}
}