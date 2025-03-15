package com.springboot.hobbyverse.dto;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class NoticeRequest {
	private String title;
	private String content;
	private String name;
	private String user_id;
	private String email;
}
