package com.springboot.hobbyverse.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;

import com.springboot.hobbyverse.service.CustomOAuth2UserService;
import com.springboot.hobbyverse.utils.JwtUtil;

import jakarta.servlet.http.Cookie;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@EnableWebSecurity
@Configuration
public class SecurityConfig {
    private final CustomOAuth2UserService customOAuth2UserService;
    private final OAuth2AuthenticationSuccessHandler oauth2AuthenticationSuccessHandler;
    private final JwtUtil jwtUtil;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable()) // CSRF 보호 비활성화 (API 사용 시)
            .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)) // JWT 사용으로 세션 없음

            .headers(headers -> headers.frameOptions(frame -> frame.disable())) // H2 콘솔 접근 허용
            .authorizeHttpRequests(auth -> auth
                    .requestMatchers("/login", "/public/**").permitAll()
            	    .requestMatchers("/**").permitAll() 
            	    .requestMatchers("/login/oauth2/**").permitAll() // OAuth2 관련 요청은 그대로 유지
            	    .anyRequest().authenticated()
            	)
            .oauth2Login(oauth2 -> oauth2
            	    .loginPage("/login")
            	    .userInfoEndpoint(userInfo -> userInfo.userService(customOAuth2UserService))
            	    .successHandler(oauth2AuthenticationSuccessHandler)
            	    .failureHandler((request, response, exception) -> {
            	        response.sendRedirect("/login?oauth2error=true"); // OAuth2 로그인 실패 시 일반 로그인으로 유도
            	    })
            	)
            .formLogin(form -> form
                    .loginPage("/login") // 커스텀 로그인 페이지
                    .loginProcessingUrl("/login") // 로그인 폼 action URL
                    .defaultSuccessUrl("/home", true)
                    .failureUrl("/login?error=true")
                )

            .logout(logout -> logout
            	    .logoutUrl("/logout") // 로그아웃 요청 URL
            	    .logoutSuccessHandler((request, response, authentication) -> {
            	        // JWT 쿠키 삭제
            	        Cookie jwtCookie = new Cookie("access_token", null);
            	        jwtCookie.setHttpOnly(true);
            	        jwtCookie.setSecure(true);
            	        jwtCookie.setPath("/");
            	        jwtCookie.setMaxAge(0); // 쿠키 즉시 삭제

            	        response.addCookie(jwtCookie);
            	        response.sendRedirect("/login"); // 로그아웃 후 로그인 페이지로 이동
            	    })
            	    )
            	    .addFilterBefore(new JwtAuthenticationFilter(jwtUtil), UsernamePasswordAuthenticationFilter.class);
        
        return http.build();
    }
    
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) 
            throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }
    @Bean
    public HttpFirewall allowDoubleSlashFirewall() {
        StrictHttpFirewall firewall = new StrictHttpFirewall();
        firewall.setAllowUrlEncodedDoubleSlash(true); // "//" 허용
        return firewall;
    }

    //비밀번호 암호화
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
