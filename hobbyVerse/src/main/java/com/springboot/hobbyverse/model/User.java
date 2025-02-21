package com.springboot.hobbyverse.model;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.hibernate.annotations.CreationTimestamp;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotEmpty;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "users")
@NoArgsConstructor(access = AccessLevel.PUBLIC)
@Getter
@Setter
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // 기본 키 자동 증가
    @Column(name = "id", updatable = false)
    private Long userId;

    @Column(name = "email", nullable = false, unique = true)
    @NotEmpty(message = "이메일(아이디)를 입력하세요")
    private String email;

    @Column(name = "password")
    private String password; // OAuth2 사용자의 경우 null일 수 있음

    @Column(name = "role")
    private String role;

    @Column(name = "name")
    private String name;
    
    @CreationTimestamp
    @Column(name = "reg_date", nullable = false, updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private LocalDateTime regDate;
    
    private String regDateString; //regDate를 문자열로 변환하여 저장하는 변수
    
    @Column(name = "provider")  // OAuth2 제공자 (google, facebook 등)
    private String provider;

    @Column(name = "provider_id", unique = true)  // OAuth2 제공자의 고유 ID
    private String providerId;
    
    @Builder
    public User(Long userId, String email, String password, LocalDateTime regDate, String regDateString, String name, String role, String provider, String providerId) {
    	this.userId = userId;
    	this.email = email;
        this.password = password;
        this.regDate = regDate;
        this.regDateString = regDateString;
        this.name = name;
        this.role = role;
        this.provider = provider;
        this.providerId = providerId;
    }
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
    
//    @OneToMany
//    private Set<MeetingApply> meetingApply;

}
