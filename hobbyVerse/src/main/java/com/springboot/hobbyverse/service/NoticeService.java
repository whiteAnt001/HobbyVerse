package com.springboot.hobbyverse.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.mapper.NoticeMapper;
import com.springboot.hobbyverse.model.Notice;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.repository.NoticeRepository;
import com.springboot.hobbyverse.repository.UserRepository;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeService {
	private final NoticeRepository noticeRepository;
	private final NoticeMapper noticeMapper;
	private final UserRepository userRepository;
	
	//공지사항 목록
	public List<Notice> getNoticeList(){
		return this.noticeMapper.getNoticeList();
	}
	//공지사항 찾기
	public Notice getNotice(Long id) {
		return noticeRepository.findById(id).orElseThrow(() 
				-> new RuntimeException("공지사항을 찾을 수 없습니다."));
	}
	
	//공지사항 작성
	public Notice saveNotice(String title, String content, String email) {
		Notice notice = new Notice();
		User user = userRepository.findByEmail(email);
		notice.setTitle(title);
		notice.setContent(content);
		notice.setUser(user);
		notice.setRegDate(LocalDateTime.now());
		return noticeRepository.save(notice);
	}
	
	//공지사항 삭제
	public void deleteNotice(Long id) {
		noticeRepository.deleteById(id);
	}
}
