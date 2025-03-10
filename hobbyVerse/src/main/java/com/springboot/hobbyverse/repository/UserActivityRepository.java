package com.springboot.hobbyverse.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.springboot.hobbyverse.model.UserActivity;

@Repository
public interface UserActivityRepository extends JpaRepository<UserActivity, Long>{
	// 특정 날짜별 유저들의 활동 조회
	List<UserActivity> findByActivityDate(LocalDate activityDate);
	// 최근 7일간 유저 활동 조회
	List<UserActivity> findByActivityDateBetween(LocalDate startDate, LocalDate endDate);
}
