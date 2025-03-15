package com.springboot.hobbyverse.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

public class SomeServiceOrController {

    public void checkUserRole() {
        // 현재 인증된 사용자 정보 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        
        if (authentication != null) {
            // 사용자의 권한 정보 확인
            authentication.getAuthorities().forEach(authority -> {
                System.out.println("권한: " + authority.getAuthority());
            });
        }
    }
}

