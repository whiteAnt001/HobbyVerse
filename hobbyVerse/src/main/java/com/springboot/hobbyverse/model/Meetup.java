package com.springboot.hobbyverse.model;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import jakarta.persistence.Id;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.persistence.Transient;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Meetup {
	@Id
	private Integer m_id;
	private String title;
	private String info;
	private Integer c_key;
	@Temporal(TemporalType.DATE)
	private Date m_date;//모임날짜
	private Integer price;
	private String w_id;
	private String imagename;
	@Temporal(TemporalType.DATE)
	private Date w_date;//등록날짜
	private Integer views; // 조회수 필드 추가
	
	private String category_name;
	private MultipartFile file;
	private Integer recommend;
}
