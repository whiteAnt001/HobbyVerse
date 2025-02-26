package com.springboot.hobbyverse.service;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springboot.hobbyverse.model.Inquiry;
import com.springboot.hobbyverse.repository.InquiryRepository;

@Service
public class InquiryService {

    private static final Logger logger = LoggerFactory.getLogger(InquiryService.class);

    @Autowired
    private InquiryRepository inquiryRepository;

    public InquiryService(InquiryRepository inquiryRepository) {
        this.inquiryRepository = inquiryRepository;
    }

    // ✅ 관리자 페이지에서 모든 문의사항 가져오기 (페이징 X) - 이메일 마스킹 X
    @Transactional(readOnly = true)
    public List<Inquiry> getAllInquiriesForAdmin() {
        logger.info("관리자 문의사항 전체 조회 요청");

        List<Inquiry> inquiries = inquiryRepository.findAllByOrderBySeqDesc();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

        inquiries.forEach(inquiry -> {
            inquiry.setFormattedCreatedAt(inquiry.getCreatedAt().format(formatter));
        });

        return inquiries;
    }

    // ✅ 일반 사용자용 모든 문의사항 조회 (페이징 지원) + 이메일 마스킹 적용
    @Transactional(readOnly = true)
    public Page<Inquiry> getAllInquiries(Pageable pageable) {
        logger.info("모든 문의사항 조회 요청 (페이징)");

        Page<Inquiry> inquiryPage = inquiryRepository.findAllByOrderBySeqDesc(pageable);

        // 일반 사용자 페이지에서는 이메일 마스킹 적용
        inquiryPage.forEach(inquiry -> inquiry.setMaskedEmail(maskEmail(inquiry.getUserEmail())));

        return inquiryPage;
    }

    // ✅ 특정 키워드 포함된 문의사항 검색 (제목 + 내용, 페이징 지원) + 이메일 마스킹 적용
    @Transactional(readOnly = true)
    public Page<Inquiry> searchInquiries(String keyword, Pageable pageable) {
        logger.info("문의사항 검색 요청: keyword={}", keyword);

        Page<Inquiry> inquiryPage = inquiryRepository.findByTitleContainingIgnoreCaseOrContentContainingIgnoreCase(keyword, keyword, pageable);

        // 일반 사용자 페이지에서는 이메일 마스킹 적용
        inquiryPage.forEach(inquiry -> inquiry.setMaskedEmail(maskEmail(inquiry.getUserEmail())));

        return inquiryPage;
    }

    // ✅ 특정 문의사항 조회 (일반 사용자 페이지에서만 이메일 마스킹 적용)
    @Transactional(readOnly = true)
    public Inquiry getInquiryById(Long id, boolean maskEmail) {
        Optional<Inquiry> inquiry = inquiryRepository.findById(id);
        if (inquiry.isPresent()) {
            Inquiry foundInquiry = inquiry.get();
            
            if (maskEmail) {
                foundInquiry.setMaskedEmail(maskEmail(foundInquiry.getUserEmail())); // ✅ 일반 사용자용 마스킹
            }

            return foundInquiry;
        }
        return null;
    }

    // ✅ 관리자 페이지에서는 이메일 마스킹 없이 조회
    @Transactional(readOnly = true)
    public Inquiry getInquiryByIdForAdmin(Long id) {
        return inquiryRepository.findById(id).orElse(null);
    }

    // ✅ 문의사항 개수 조회 추가
    @Transactional(readOnly = true)
    public Integer getInquiryCount() {
        return (int) inquiryRepository.count();
    }

    // ✅ 문의 등록 (seq 자동 증가 설정)
    @Transactional
    public Inquiry saveInquiry(Inquiry inquiry) {
        logger.info("문의 등록 요청: {}", inquiry);
        inquiry.setSeq(getNextSeq()); // ✅ seq 자동 증가
        return inquiryRepository.save(inquiry);
    }

    // ✅ 문의 삭제
    @Transactional
    public void deleteInquiry(Long id) {
        logger.info("문의 삭제 요청: id={}", id);
        inquiryRepository.deleteById(id);
    }

    // ✅ 새로운 seq 값 가져오기 (최대 seq 값 +1)
    public Integer getNextSeq() {
        return Optional.ofNullable(inquiryRepository.findMaxSeq()).orElse(0) + 1;
    }

    // ✅ 이메일 마스킹 로직 (예: ***@domain.com)
    private String maskEmail(String email) {
        if (email != null && email.contains("@")) {
            String[] parts = email.split("@", 2);
            return "***@" + parts[1]; // ***@도메인.com 형식
        }
        return email;
    }

    // ✅ 관리자용 문의사항 수정 기능 (PUT 요청 대응)
    @Transactional
    public Inquiry updateInquiry(Long id, String title, String content) {
        Inquiry inquiry = inquiryRepository.findById(id).orElse(null);
        if (inquiry != null) {
            inquiry.setTitle(title);
            inquiry.setContent(content);
            return inquiryRepository.save(inquiry);
        }
        return null;
    }
}
