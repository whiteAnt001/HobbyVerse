package com.springboot.hobbyverse.model;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Recommend {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer r_id;
	private Integer m_id;
	private String email;
}
