package com.springboot.hobbyverse.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class TopCategoryDTO {
	private String category;
	private Integer meeting_count;
}
