package com.springboot.hobbyverse.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Transient;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Report {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // 기본 키 자동 증가
	private Integer report_id;
	private Integer m_id;
	private String name;
	private String reason;
	private LocalDateTime report_date;
    @Transient
	private String formattedReport_date;
	private Integer report_count;
	
	private Meetup meetup;
	
    public String getformattedReport_date() {
        if (report_date != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            return report_date.format(formatter);
        }
        return null;
    }
}
