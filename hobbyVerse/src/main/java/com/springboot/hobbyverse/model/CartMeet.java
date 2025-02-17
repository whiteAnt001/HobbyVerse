package com.springboot.hobbyverse.model;

import java.sql.Date;

import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CartMeet {
	private Integer m_id;
	private String title;
	private String info;
	private Integer c_key;
	@Temporal(TemporalType.DATE)
	private Date w_date;
	private Integer price;
	private String w_id;
	private String imagename;
	
	private String name;
	private String email;
	
}
