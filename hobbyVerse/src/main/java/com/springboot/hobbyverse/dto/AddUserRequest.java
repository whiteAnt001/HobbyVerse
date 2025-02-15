package com.springboot.hobbyverse.dto;

import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AddUserRequest {
	private String name;
    private String email;
    private String password;
    private String role;
    private String provider;
    private String providerId;
    
    public boolean isOAuth() { //OAuth 사용자인지 체크
    	return provider != null && !providerId.isEmpty();
    }
}
