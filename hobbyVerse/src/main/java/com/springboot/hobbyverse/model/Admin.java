package com.springboot.hobbyverse.model;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotEmpty;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "admins")
@NoArgsConstructor(access = AccessLevel.PUBLIC)
@Getter
@Setter
public class Admin implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) //기본 키 값이 자동으로 증가 (중복 방지)
    @Column(name = "id", updatable = false) //id컬럼과 매핑, 컬럼값 수정 false
    private Long id;
    @Column(name = "email", nullable = false, unique = true) // email컬럼과 매핑, not null, unique 제약조건 추가
    @NotEmpty(message = "이메일(아이디)를 입력하세요")
    private String email;
    @Column(name = "password")
	@NotEmpty(message = "비밀번호를 입력하세요.")
    private String password;

    @Builder
    public Admin(String email, String password, String name) {
        this.email = email;
        this.password = password;
        this.name = name;
    }

    @Override //권한 반환
    public Collection<? extends GrantedAuthority> getAuthorities(){
        return List.of(new SimpleGrantedAuthority("admin"));
    }
    
    //사용자의 id를 반환(고유한 값)
    @Override
    public String getUsername() {
        return email;
    }
    
    //사용자의 패스워드 반환
    @Override
    public String getPassword() {
        return password;
    }
    
    //계정 만료 여부 반환
    @Override
    public boolean isAccountNonExpired() {
        //만료되었는지 확인하는 로직
        return true; //true -> 만료되지 않았음
    }
    
    //계정 잠금 여부 반환
    @Override
    public boolean isAccountNonLocked() {
        //계정 잠금되었는지 확인하는 로직
        return true; //true -> 잠금되지 않았음
    }
    
    //패스워드의 만료 여부 반환
    @Override
    public boolean isCredentialsNonExpired() {
        //패스워드가 만료되었는지 확인하는 로직
        return true; //true -> 만료되지 않았음
    }
    
    @Override
    public boolean isEnabled(){
        //계정이 사용 가능한지 확인하는 로직
        return true; //true -> 사용 가능
    }

    @Column(name = "name", unique = true)
    private String name;

    //사용자 이름 변경
    public Admin update(String nickname){
        this.name = nickname;

        return this;
    }

}
