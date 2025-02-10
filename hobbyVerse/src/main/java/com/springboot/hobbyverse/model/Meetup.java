package com.springboot.hobbyverse.model;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Meetup {
	private Integer m_id;
	private String title;
	private String info;
	private Integer c_key;
	private Date w_date;
	private Integer price;
	private String w_id;
	private String imagename;
	
	private MultipartFile file;
}
