package com.springboot.hobbyverse.config;

import java.io.IOException;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import com.auth0.jwt.interfaces.DecodedJWT;
import com.springboot.hobbyverse.utils.JwtUtil;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@Component
public class JwtFilter extends OncePerRequestFilter {

    private final JwtUtil jwtUtil;
    private final UserDetailsService userDetailsService; // 추가

    public JwtFilter(JwtUtil jwtUtil, UserDetailsService userDetailsService) {
        this.jwtUtil = jwtUtil;
        this.userDetailsService = userDetailsService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws ServletException, IOException {
        String token = request.getHeader("Authorization");

        if (token != null && token.startsWith("Bearer ")) {
            token = token.substring(7);

            if (jwtUtil.validateToken(token)) {
                DecodedJWT decodedJWT = jwtUtil.getDecodedJWT(token);
                String userName = decodedJWT.getSubject();

                // 🔹 UserDetailsService를 사용하여 사용자 정보 로드
                UserDetails userDetails = userDetailsService.loadUserByUsername(userName);

                SecurityContextHolder.getContext().setAuthentication(
                        new JwtAuthenticationToken(userDetails, token, userDetails.getAuthorities()));
            }
        }

        chain.doFilter(request, response);
    }
}
