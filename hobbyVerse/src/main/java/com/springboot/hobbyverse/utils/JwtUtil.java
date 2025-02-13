
package com.springboot.hobbyverse.utils;

import java.time.Duration;
import java.util.Date;

import org.springframework.stereotype.Component;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.SignatureVerificationException;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.auth0.jwt.interfaces.JWTVerifier;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class JwtUtil {
	private static final String SECRET = "HobbyVers";
	private static final Algorithm ALGORITHM = Algorithm.HMAC512(SECRET);
	private static final long ACCESS_TOKEN_EXPIRATION = 900000L;
	private static final long REFRESH_TOKEN_EXPIRATION = Duration.ofDays(7).toMillis();

	// 토큰 생성
	public static String generateToken(String email, String userName, String role) {
		return JWT.create()
				.withSubject(email) //
				.withClaim("userName", userName) // 유저
				.withClaim("role", role) // 권한
				.withIssuedAt(new Date()) // 발급시간
				.withExpiresAt(new Date(System.currentTimeMillis() + ACCESS_TOKEN_EXPIRATION)) // AccessToken유효시간
				.sign(ALGORITHM);
	}
	

	// 리프레시 토큰 생성
	public static String generateRefreshToken(String email) {
		return JWT.create().withSubject(email).withIssuedAt(new Date()) // 발급시간
				.withExpiresAt(new Date(System.currentTimeMillis() + REFRESH_TOKEN_EXPIRATION)) // RefreshToken유효시간
				.sign(ALGORITHM);
	}
	
	//토큰을 쿠키에 추가
    public void addJwtToCookie(HttpServletResponse response, String jwt) {
        Cookie cookie = new Cookie("jwt", jwt);  // "jwt"라는 이름의 쿠키에 토큰 저장
        cookie.setHttpOnly(true);  // JavaScript에서 접근할 수 없도록 설정
        cookie.setSecure(true);    // HTTPS 프로토콜에서만 전송되도록 설정
        cookie.setPath("/");       // 모든 경로에서 접근 가능
        cookie.setMaxAge(86400);   // 1일 동안 쿠키 유효 (초 단위)
        response.addCookie(cookie);
    }
    
    // 쿠키에서 JWT 토큰을 가져오는 메서드
    public String getJwtFromCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("jwt".equals(cookie.getName())) {  // 쿠키 이름이 "jwt"인 경우
                    return cookie.getValue();  // JWT 값 반환
                }
            }
        }
        return null;  // JWT 쿠키가 없으면 null 반환
    }

    //JWT검증
    public static boolean validateToken(String token) {
        try {
            JWTVerifier verifier = JWT.require(ALGORITHM).build();
            verifier.verify(token);
            return true;
        } catch (TokenExpiredException e) {
            System.out.println("JWT 만료됨: " + e.getMessage());
        } catch (SignatureVerificationException e) {
            System.out.println("JWT 서명 오류: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("JWT 검증 실패: " + e.getMessage());
        }
        return false;
    }

    public static DecodedJWT getDecodedJWT(String token) {
        try {
            return JWT.require(ALGORITHM).build().verify(token);
        } catch (Exception e) {
            System.out.println("토큰 디코딩 실패: " + e.getMessage());
            return null;
        }
    }
}
