package com.springboot.hobbyverse;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;

@SpringBootApplication
@EntityScan(basePackages = "com.springboot.hobbyverse.model")
public class HobbyVerseApplication {

	public static void main(String[] args) {
		SpringApplication.run(HobbyVerseApplication.class, args);
	}

}