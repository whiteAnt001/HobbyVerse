package com.springboot.hobbyverse.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.dto.AddUserRequest;
import com.springboot.hobbyverse.mapper.MyMapper;
import com.springboot.hobbyverse.model.Admin;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.repsitory.AdminRepository;

import lombok.RequiredArgsConstructor;
@RequiredArgsConstructor
@Service
public class AdminService {
	@Autowired
	private AdminRepository adminRepository;
	@Autowired
	private MyMapper myMapper;
	
	private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	//관리자 정보 찾기
	public Admin getUser(Admin admin) {
		return this.myMapper.getAdmin(admin);
	}
	
    
	//관리자 정보 저장
    public Long save(AddUserRequest dto){
        return adminRepository.save(Admin.builder()
        		.name(dto.getName())
                .email(dto.getEmail())
                //패스워드를 저장할 땐 패스워드 인코딩용으로 등록한 빈을 사용해서 암호화 후 저장
                .password(passwordEncoder.encode(dto.getPassword()))
                .build()).getId();
    }
    
    // 로그인 시 사용자가 입력한 비밀번호와 DB에 저장된 암호화된 비밀번호를 비교
    public boolean checkPassword(String rawPassword, String encryptedPassword) {
    	return passwordEncoder.matches(rawPassword, encryptedPassword);
    }
}
