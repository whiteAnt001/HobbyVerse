package com.springboot.hobbyverse.service;

import javax.security.auth.login.LoginException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

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
	
	private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
    public User login(String email, String password) throws LoginException {
        
        if (userRepository.findByEmail(email).isPresent()) {
            User user = userRepository.findByEmail(email).get();
            
            // 비밀번호 비교 (비밀번호를 암호화 시켰기 때문에 단순비교 불가)
            if (passwordEncoder.matches(password, user.getPassword())) {
                return user; // 비밀번호가 일치하면 로그인 성공
            }
        }
        
        throw new LoginException("로그인중 오류 발생."); // 로그인 실패
    }
	
    public Long save(AddUserRequest dto){
        return userRepository.save(User.builder()
                .email(dto.getEmail())
                //패스워드를 저장할 땐 패스워드 인코딩용으로 등록한 빈을 사용해서 암호화 후 저장
                .password(passwordEncoder.encode(dto.getPassword()))
                .build()).getId();
    }
    
    
}
