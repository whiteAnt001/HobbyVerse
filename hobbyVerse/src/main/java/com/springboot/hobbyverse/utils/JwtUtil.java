package com.springboot.hobbyverse.utils;


import java.security.AlgorithmConstraints;
import java.security.Key;
import java.time.Duration;
import java.util.Date;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.auth0.jwt.interfaces.JWTVerifier;
@Component
public class JwtUtil {
	private static final String SECRET = "HobbyVers";
	private static final Algorithm ALGORITHM = Algorithm.HMAC512(SECRET);
	private static final long ACCESS_TOKEN_EXPIRATION = 900000L;
	private static final long REFRESH_TOKEN_EXPIRATION = Duration.ofDays(7).toMillis();
	
	public static String generateToken(String email, String userName, String role) {
		return JWT.create()
				.withSubject(email) // 
				.withClaim("userName", userName) // 유저
				.withClaim("role", role) // 권한
				.withIssuedAt(new Date()) // 발급시간
				.withExpiresAt(new Date(System.currentTimeMillis() + ACCESS_TOKEN_EXPIRATION)) // AccessToken유효시간
				.sign(ALGORITHM);
	}
	
	public static String generateRefreshToken(String email) {
		return JWT.create()
				.withSubject(email)
				.withIssuedAt(new Date()) //발급시간
				.withExpiresAt(new Date(System.currentTimeMillis() + REFRESH_TOKEN_EXPIRATION)) // RefreshToken 유료시간
				.sign(ALGORITHM);
	}
	
	public static boolean validateToken(String token) {
		try {
			JWTVerifier verifier = JWT.require(ALGORITHM).build();
			verifier.verify(token);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	public static DecodedJWT getDecodedJWT(String token) {
		return JWT.require(ALGORITHM).build().verify(token); 
	}
}
