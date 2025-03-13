package com.springboot.hobbyverse.config;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.springboot.hobbyverse.repository.MeetupRepository;

@Component
public class MeetupCleanupScheduler {

	@Autowired
	private MeetupRepository meetupRepository;
	
	//매일 자정에 실행
	@Scheduled(cron = "0 0 0 * * ?")
	public void deleteExpiredMeetup() {
		LocalDateTime now = LocalDateTime.now(); //현재시간
		meetupRepository.deleteByMDateBefore(now);
	}
	
}
