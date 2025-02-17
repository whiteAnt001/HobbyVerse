package com.springboot.hobbyverse.service;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.config.SecurityConfig;
import com.springboot.hobbyverse.dto.AddUserRequest;
import com.springboot.hobbyverse.mapper.MyMapper;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.repository.UserRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private MyMapper myMapper;
    @Autowired
    private SecurityConfig securityConfig;

    // 유저 정보 찾기
    public User getUser(User user) {
        return this.myMapper.getUser(user);
    }

    // 모든 유저의 수 찾기
    public Integer getUserCount() {
        return this.myMapper.getUserCount();
    }

    // 사용자의 id를 이용해 email 조회
    public String getUserIdByUserId(Long userId) {
        User user = userRepository.findByUserId(userId);
        return user != null ? user.getEmail() : null; // 사용자가 있으면 ID 반환, 없으면 null
    }

    // 사용자의 email을 이용해 role 조회
    public String getUserRole(String email) {
        User user = userRepository.findByEmail(email);
        return user != null ? user.getRole() : null; // 사용자가 있으면 role 반환, 없으면 null
    }

    // 사용자 정보 저장 (회원가입)
    @Transactional
    public User saveUser(AddUserRequest dto) {

        // 회원가입시 이메일이 사용중인지 확인
        if (userRepository.existsByEmail(dto.getEmail())) {
            throw new IllegalArgumentException("이미 사용 중인 이메일입니다.");
        }

        // 비밀번호를 암호화해서 저장
        String encodedPassword = securityConfig.passwordEncoder().encode(dto.getPassword());

        // 사용자 객체 생성 (닉네임은 조건에 맞게 저장)
        User user = User.builder()
        		.userId(dto.getId())
                .email(dto.getEmail())
                .password(encodedPassword)  // 비밀번호 암호화 저장
                .name(dto.getName())
                .role("ROLE_USER")
                .regDate(LocalDateTime.now())
                .regDateString(dto.getRegDateString())
                .provider(null)  // 폼 로그인에서는 provider가 없으므로 null
                .providerId(null)  // 폼 로그인에서는 providerId가 없으므로 null
                .build();

        // 사용자 저장
        return userRepository.save(user);
    }


    // 로그인 시 사용자가 입력한 비밀번호와 DB에 저장된 암호화된 비밀번호를 비교
    public boolean checkPassword(String rawPassword, String encryptedPassword) {
        return securityConfig.passwordEncoder().matches(rawPassword, encryptedPassword);
    }

    // 비밀번호 변경
    public boolean changePassword(String email, String currentPassword, String newPassword) {
        // 유저 정보 검색
        User user = userRepository.findByEmail(email);

        // 현재 비밀번호 검증
        if (!securityConfig.passwordEncoder().matches(currentPassword, user.getPassword())) {
            return false;
        }

        // 새 비밀번호 암호화 후 저장
        user.setPassword(securityConfig.passwordEncoder().encode(newPassword));
        userRepository.save(user);
        return true;
    }

    // 인증 처리 (로그인)
    public boolean authenticate(String email, String password) {
        User user = userRepository.findByEmail(email);

        if (user == null) {
            return false; // 사용자가 존재하지 않음
        }

        // 비밀번호가 일치하는지 확인
        return securityConfig.passwordEncoder().matches(password, user.getPassword());
    }
}
