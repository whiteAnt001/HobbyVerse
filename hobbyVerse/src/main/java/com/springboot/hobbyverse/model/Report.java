package com.springboot.hobbyverse.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Report {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // 기본 키 자동 증가
	@Column(name="m_id")
	private Integer report_id;
	private Integer m_id;
	private String name;
	private String reason;
	private LocalDateTime report_date;
	private Integer report_count;
	
	private Meetup meetup;
}
