package com.springboot.hobbyverse;  

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@MapperScan("com.springboot.hobbyverse.mapper")
@EnableScheduling //스케줄러 기능 활성화
@EnableJpaRepositories(basePackages = "com.springboot.hobbyverse.repository")
public class HobbyVerseApplication extends SpringBootServletInitializer{
	
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(HobbyVerseApplication.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(HobbyVerseApplication.class, args);
	}
}
