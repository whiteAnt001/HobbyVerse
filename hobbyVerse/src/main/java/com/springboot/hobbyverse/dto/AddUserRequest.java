package com.springboot.hobbyverse.dto;

import java.time.LocalDateTime;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AddUserRequest {
	private Long id;
	private String name;
    private String email;
    private String password;
    private LocalDateTime regDate;
    private String role;
    private String provider;
    private String providerId;
    
    public boolean isOAuth() { //OAuth 사용자인지 체크
    	return provider != null && !providerId.isEmpty();
    }
}
