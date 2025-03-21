package com.springboot.hobbyverse.config;

import java.io.IOException;

import org.springframework.security.core.Authentication;

import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.utils.JwtUtil;
import com.springboot.hobbyverse.repository.UserRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Component
public class OAuth2AuthenticationSuccessHandler implements AuthenticationSuccessHandler{
	private final UserRepository userRepository;
	private final JwtUtil jwtUtil;	

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		OAuth2User oauthUser = (OAuth2User) authentication.getPrincipal(); //로그인한 사용자 정보 가져오기
		//OAuth에서 받아온 사용자 정보
		String email = oauthUser.getAttribute("email");
		String name = oauthUser.getAttribute("name");
		String role = "ROLE_USER";
		
        // JWT 생성
		String accessToken = JwtUtil.generateToken(email, name, role);
		String refreshToken = JwtUtil.generateRefreshToken(email);
        
        // 응답 헤더에 JWT 추가
        response.setHeader("Authorization", "Bearer " + accessToken);
        response.setHeader("Refresh-Token", refreshToken);
		
        //JWT를 쿠키에 저장
        jwtUtil.addJwtToCookie(response, accessToken);
		//DB에서 사용자 정보 가져오기'
		User user = userRepository.findByEmail(email);
		
		//세션에 사용자 정보 저장
		HttpSession session = request.getSession();
		session.setAttribute("loginUser", user);
		response.sendRedirect("/home");
	}
	
}
