package com.springboot.hobbyverse;

import java.sql.Date;

import com.springboot.hobbyverse.model.Meetup;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MeetingApply {
	@Id
	private Integer apply_id;
	private Long id;
	private Integer m_id;
	@Temporal(TemporalType.DATE)
	private Date apply_date;
}
