package com.springboot.hobbyverse.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.config.SecurityConfig;
import com.springboot.hobbyverse.dto.AddUserRequest;
import com.springboot.hobbyverse.mapper.MyMapper;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.repsitory.UserRepository;

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
	
	//유저 정보 찾기
	public User getUser(User user) {
		return this.myMapper.getUser(user);
	}
	
    
	//유저 정보 저장
    public Long save(AddUserRequest dto){
        return userRepository.save(User.builder()
        		.name(dto.getName())
                .email(dto.getEmail())
                //패스워드를 저장할 땐 패스워드 인코딩용으로 등록한 빈을 사용해서 암호화 후 저장
                .password(securityConfig.passwordEncoder().encode(dto.getPassword()))
                .role("ROLE_USER")
                .build()).getId();
    }
    
    // 로그인 시 사용자가 입력한 비밀번호와 DB에 저장된 암호화된 비밀번호를 비교
    public boolean checkPassword(String rawPassword, String encryptedPassword) {
    	return securityConfig.passwordEncoder().matches(rawPassword, encryptedPassword);
    }
    
    public boolean changePassword(String email, String currentPassword, String newPassword) {
    	//유저 정보 검색
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
}
