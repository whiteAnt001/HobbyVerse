package com.springboot.hobbyverse.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springboot.hobbyverse.dto.TopCategoryDTO;
import com.springboot.hobbyverse.mapper.MeetingMapper;
import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.Recommend;
import com.springboot.hobbyverse.model.StartEnd;
import com.springboot.hobbyverse.repository.MeetupRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MeetingService {

	private static final Logger logger = LoggerFactory.getLogger(MeetingService.class);
	private final MeetupRepository meetupRepository;

	@PersistenceContext
	private EntityManager entityManager; // JPA 캐시 강제 새로고침

	private final MeetingMapper meetingMapper;

	public List<TopCategoryDTO> getTopMeetingCategories() {
		LocalDateTime startDate = LocalDateTime.now().minusDays(7);
		List<Object[]> results = meetupRepository.findTopMeetingCategories(startDate);

		return results.stream().map(row -> new TopCategoryDTO((String) row[1], ((Long) row[2]).intValue()))
				.collect(Collectors.toList());
	}

	public List<Category> getCategoryList() {
		return meetingMapper.getCategoryList();
	}

	public void putMeeting(Meetup meetup) {
		meetup.setM_id(this.getMaxId() + 1);
		meetingMapper.putMeeting(meetup);
	}

	public List<Meetup> getMeetList(Integer pageNo) {
		if (pageNo == null)
			pageNo = 1;
		int start = (pageNo - 1) * 4;
		int end = ((pageNo - 1) * 4) + 5;
		StartEnd se = new StartEnd();
		se.setStart(start);
		se.setEnd(end);
		return meetingMapper.getMeetList(se);
	}

	public Integer getTotal() {
		return meetingMapper.getTotal();
	}

	public Integer getMaxId() {
		Integer max = meetingMapper.getMaxId();
		return (max == null) ? 0 : max;
	}

	@Transactional(readOnly = true)
	public Meetup getMeetDetail(Integer id) {
		entityManager.clear(); // JPA 캐시 제거 (최신 데이터 강제 조회)
		return meetupRepository.findById(id).orElse(null); // DB에서 강제 조회
	}

	public void updateMeeting(Meetup meetup) {
		meetingMapper.updateMeeting(meetup);
	}

	public Integer deleteById(Integer id) {
		return meetingMapper.deleteById(id);
	}

	public List<Meetup> getMeetingByUser(String email) {
		return meetingMapper.getMeetingByUser(email);
	}

	public List<Meetup> getMeetings(Integer pageNo) {
		if (pageNo == null)
			pageNo = 1;
		int start = (pageNo - 1) * 6;
		int end = ((pageNo - 1) * 6) + 7;
		StartEnd se = new StartEnd();
		se.setStart(start);
		se.setEnd(end);
		return meetingMapper.getMeetings(se);
	}

	public Meetup getMeetingById(Integer id) {
		return meetingMapper.getMeetingById(id);
	}

	public List<Meetup> getMeetByTitle(String title, Integer pageNo) {
		if (pageNo == null)
			pageNo = 1;
		int start = (pageNo - 1) * 4;
		int end = start + 5;
		StartEnd se = new StartEnd();
		se.setStart(start);
		se.setEnd(end);
		se.setTitle(title);
		return meetingMapper.getMeetByTitle(se);
	}

	public Integer getMeetCountByTitle(String title) {
		return meetingMapper.getMeetCountByTitle(title);
	}

	public List<Recommend> getRecommend(Recommend recommend) {
		return meetingMapper.getRecommend(recommend);
	}

	public void putRecommend(int m_id, String email) {
		meetingMapper.putRecommend(m_id, email);
	}

	public Integer getRecommendCheck(Integer m_id, String email) {
		return meetingMapper.getRecommendCheck(m_id, email);
	}

	public void updateRecommendCount(Integer m_id) {
		meetingMapper.updateRecommendCount(m_id);
	}

	public Integer getViews(Integer id) {
		return meetingMapper.getViews(id);
	}

	// 조회수 증가 (JPA 기본 방식)
	@Transactional
	public void incrementViews(Integer id) {
		Meetup meetup = meetupRepository.findById(id).orElse(null);
		if (meetup != null) {
			logger.info("현재 조회수: {}", meetup.getViews()); // 현재 조회수 로그 출력
			meetup.setViews(meetup.getViews() + 1);
			meetupRepository.save(meetup); // ✅ 조회수 증가 후 저장
			entityManager.flush(); // ✅ DB에 즉시 반영
			entityManager.refresh(meetup); // ✅ JPA 캐시 강제 새로고침
			// logger.info("업데이트된 조회수: {}", meetup.getViews()); // ✅ 업데이트된 조회수 로그 출력
			meetupRepository.save(meetup); // 조회수 증가 후 저장
			entityManager.flush(); // DB에 즉시 반영
			entityManager.refresh(meetup); // JPA 캐시 강제 새로고침
			logger.info("업데이트된 조회수: {}", meetup.getViews()); // 업데이트된 조회수 로그 출력
		} else {
			logger.warn("조회수 증가 실패: meetup ID {}를 찾을 수 없음", id);
		}
	}

	// 강제 DB 업데이트 (JPA가 적용되지 않을 경우)
	@Transactional
	public void incrementViewsDirectly(Integer id) {
		int updatedRows = meetupRepository.incrementViewsById(id);
	}

	public Meetup getMeet(Integer m_id) {
		return meetingMapper.getMeet(m_id);
	}

	public String getW_id(Integer m_id) {
		return meetingMapper.getW_id(m_id);
	}

	// 기존 이미지 사용하기 위한 서비스
	public String getExistingImagename(Integer m_id) {
		// m_id에 해당하는 모임 정보를 조회하여 imagename 반환
		Meetup meetup = meetupRepository.findById(m_id).orElse(null);
		if (meetup != null) {
			return meetup.getImagename();
		}
		return null; // 해당 모임이 없으면 null 반환
	}

	// 기존 위도 가져오는 메서드
	public double getExistingLatitude(int mId) {
		// m_id를 통해 해당 모임의 위도를 가져옴
		return meetingMapper.getLatitudeByMeetingId(mId);
	}

	// 기존 경도 가져오는 메서드
	public double getExistingLongitude(int mId) {
		// m_id를 통해 해당 모임의 경도를 가져옴
		return meetingMapper.getLongitudeByMeetingId(mId);
	}

	public List<Meetup> meetListKorean(Integer start, Integer end) {
		return meetingMapper.meetListKorean(start, end);
	}
	
	public List<Meetup> meetListRegist(Integer start, Integer end) {
		return meetingMapper.meetListRegist(start, end);
	}
	
	public List<Meetup> meetListRecommend(Integer start, Integer end) {
		return meetingMapper.meetListRecommend(start, end);
	}

}
