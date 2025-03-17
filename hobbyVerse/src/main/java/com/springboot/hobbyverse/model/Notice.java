package com.springboot.hobbyverse.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "notices")
@Getter
@Setter
public class Notice {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "notice_seq")
	@SequenceGenerator(name = "notice_seq", sequenceName = "notice_seq", allocationSize = 1)
	private Long id;
	
	@Column(name = "name", columnDefinition = "TEXT")
	private String name;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;
	
	@Column(name = "title", nullable = false, columnDefinition = "TEXT")
	private String title;
	
	@Column(name = "content", nullable = false)
	private String content;
	
	@Column(name = "reg_date", nullable = false)
	private LocalDateTime regDate;
	
	@Column(name = "view", nullable = false)
	private Integer view = 0;
	
    @Transient
    public String getRegDateString() {
        if (regDate == null) return "";
        return regDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }
}
