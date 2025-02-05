package com.springboot.hobbyverse.config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@EnableWebSecurity
@Configuration
public class SecurityConfig {
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())  // CSRF 비활성화
            .headers(headers -> headers.frameOptions(frame -> frame.disable()))  // H2 콘솔 접근 허용
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/h2-console/**", "/**").permitAll()  // 모든 요청 허용
                .anyRequest().permitAll()
            )
            .formLogin(form -> form.disable())  // 로그인 페이지 비활성화
            .httpBasic(httpBasic -> httpBasic.disable());  // HTTP Basic 인증 비활성화

        return http.build();
    }
}

