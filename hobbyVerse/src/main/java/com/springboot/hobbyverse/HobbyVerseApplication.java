package com.springboot.hobbyverse;  

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@MapperScan("com.springboot.hobbyverse.mapper")
@EnableJpaRepositories(basePackages = "com.springboot.hobbyverse.repository")
public class HobbyVerseApplication {

	public static void main(String[] args) {
		SpringApplication.run(HobbyVerseApplication.class, args);
	}
}
