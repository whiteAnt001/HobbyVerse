package com.springboot.hobbyverse.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.springboot.hobbyverse.model.Board;
import com.springboot.hobbyverse.model.Notice;


@Repository
public interface NoticeRepository extends JpaRepository<Notice, Long> {
	Optional<Notice> findById(Long id);
	
	@Query(value = "SELECT * FROM notices ORDER BY reg_date DESC LIMIT 3", nativeQuery = true)
	List<Notice> getNoticeList();
}
