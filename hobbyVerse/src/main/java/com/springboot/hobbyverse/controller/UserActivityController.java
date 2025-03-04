package com.springboot.hobbyverse.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.springboot.hobbyverse.model.UserActivity;
import com.springboot.hobbyverse.service.UserActivityService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("api/user-activity")
@RequiredArgsConstructor
public class UserActivityController {
	private final UserActivityService userActivityService;

	
	//특정 날짜의 유저 활도 조회 api
	@GetMapping("/{date}")
	public List<UserActivity> getUserActivityByDate(@PathVariable String date){
		LocalDate activityDate = LocalDate.parse(date);
		return this.userActivityService.getUserActivityByDate(activityDate);
	}
	
	// 최근 7일간 유저 활동 조회 api
	@GetMapping("/recent")
	public List<UserActivity> getfindByActivityDateBetween(){
		return this.userActivityService.getRecentUserActivities();
	}
	
	// 새로운 유저 활동 데이터 저장 api
	@GetMapping("/save")
	public UserActivity saveUserActivity(@RequestBody UserActivity userActivity) {
		return this.userActivityService.saveUserActivity(userActivity);
	}
}
