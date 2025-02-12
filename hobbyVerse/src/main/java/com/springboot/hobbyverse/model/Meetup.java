package com.springboot.hobbyverse.model;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import jakarta.persistence.ManyToOne;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Meetup {
	private Integer m_id;
	private String title;
	private String info;
	private Integer c_key;
	@Temporal(TemporalType.DATE)
	private Date w_date;
	private Integer price;
	private String imagename;
	private String w_id;

	private MultipartFile file;
	
	@ManyToOne
	private Category category;
}
