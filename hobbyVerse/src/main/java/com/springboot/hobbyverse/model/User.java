package com.springboot.hobbyverse.model;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotEmpty;
import lombok.*;

@Entity
@Table(name = "users")
@NoArgsConstructor(access = AccessLevel.PUBLIC)
@Getter
@Setter
public class User implements UserDetails {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // 기본 키 자동 증가
    @Column(name = "id", updatable = false)
    private Long id;

    @Column(name = "email", nullable = false, unique = true)
    @NotEmpty(message = "이메일(아이디)를 입력하세요")
    private String email;

    @Column(name = "password")
    private String password; // OAuth2 사용자의 경우 null일 수 있음

    @Column(name = "role")
    private String role;

    @Column(name = "name", unique = true)
    private String name;

    @Column(name = "provider")  // OAuth2 제공자 (google, facebook 등)
    private String provider;

    @Column(name = "provider_id", unique = true)  // OAuth2 제공자의 고유 ID
    private String providerId;

    @Builder
    public User(String email, String password, String name, String role, String provider, String providerId) {
        this.email = email;
        this.password = password;
        this.name = name;
        this.role = role;
        this.provider = provider;
        this.providerId = providerId;
    }

    // OAuth2 로그인 시 사용자 정보 업데이트
    public User update(String name) {
        this.name = name;
        return this;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(role));
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
