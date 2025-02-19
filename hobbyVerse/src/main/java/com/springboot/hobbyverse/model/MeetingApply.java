package com.springboot.hobbyverse.model;

import java.sql.Date;

import jakarta.annotation.Generated;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Getter;
import lombok.Setter;
@Entity
@Getter
@Setter

public class MeetingApply {
	@Id
	//@GeneratedValue(strategy = GenerationType.IDENTITY)
	@GeneratedValue(strategy = GenerationType.SEQUENCE) 
	private Long id;  //계정
	private String email; //이메일
	private Integer m_id; //모임 아이디
	@Temporal(TemporalType.DATE)
	private Date apply_date;
	//, generator = "apply_id_seq"
}
     