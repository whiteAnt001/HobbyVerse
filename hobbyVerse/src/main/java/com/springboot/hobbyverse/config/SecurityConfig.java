package com.springboot.hobbyverse.config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.springboot.hobbyverse.service.UserDetailService;

@EnableWebSecurity
@Configuration
public class SecurityConfig {
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
	    http
	    .csrf(csrf -> csrf.disable())  // CSRF 비활성화 (실무에선 확성화하는게 좋음)
	    .headers(headers -> headers.frameOptions(frame -> frame.disable()))  // H2 콘솔 접근 허용
	    .authorizeHttpRequests(auth -> auth
	            .requestMatchers("/h2-console/**", "/**").permitAll()  // 모든 요청 허용
	            .anyRequest().permitAll()
	    )
	    .formLogin(form -> form
	        .loginPage("/login")  // 로그인 페이지 URL 설정
	        .defaultSuccessUrl("/home")  // 로그인 성공 후 이동할 URL 설정
	    )
	    .logout(logout -> logout  // 로그아웃 설정
	        .logoutSuccessUrl("/login")  // 로그아웃 성공시 로그인 창으로 변경
	        .invalidateHttpSession(true)  // 로그아웃 이후 세션의 삭제 여부
	    )
	    .httpBasic(httpBasic -> httpBasic.disable());  // HTTP Basic 인증 비활성화

	    return http.build();
	}


    
    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity http, BCryptPasswordEncoder bCryptPasswordEncoder, UserDetailService userDetailService) throws Exception {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailService); //사용자 정보 서비스 설정
        authProvider.setPasswordEncoder(bCryptPasswordEncoder); //비밀번호를 암호화 하기 위한 인코더 설정
        return new ProviderManager(authProvider);
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}

