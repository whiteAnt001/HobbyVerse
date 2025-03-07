package com.springboot.hobbyverse.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @GetMapping("/me")
    public String getCurrentUser() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        
        
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        System.out.println("Authenticated User: " + authentication.getName());
        System.out.println("Authorities: " + authentication.getAuthorities());
        
        if (principal instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) principal;
            return "사용자: " + userDetails.getUsername() + ", 권한: " + userDetails.getAuthorities();
        }
        return "인증되지 않음";
    }
}
