package com.springboot.hobbyverse.model;

import java.sql.Date;

import jakarta.annotation.Generated;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Getter;
import lombok.Setter;
@Entity
@Getter
@Setter
public class MeetingApply {
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_seq")
    @SequenceGenerator(name = "user_seq", sequenceName = "user_sequence", allocationSize = 1)
	//@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Id   
	private Long apply_id;//참가신청 순서
	private Long id; //계정
	private String name; //닉네임
	private String eamil;//이메일
	@Column(name="m_id")
	private Integer mid; //모임 아이디
	private String title;//모임 이름
	@Temporal(TemporalType.DATE)
	private Date apply_date;//침가 신청일
	
}
     