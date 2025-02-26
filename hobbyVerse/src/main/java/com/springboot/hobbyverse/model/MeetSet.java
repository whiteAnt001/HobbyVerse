package com.springboot.hobbyverse.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MeetSet {
	private Meetup meet;
	private Integer quantity;
	
	public MeetSet(Meetup meet, Integer quantity) {
		this.meet = meet;
		this.quantity = quantity;
	}
}
