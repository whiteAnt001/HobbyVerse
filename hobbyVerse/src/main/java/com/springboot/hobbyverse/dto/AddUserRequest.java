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
}
