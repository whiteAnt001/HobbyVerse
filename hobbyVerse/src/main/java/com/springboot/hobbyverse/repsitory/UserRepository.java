package com.springboot.hobbyverse.repsitory;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.springboot.hobbyverse.dto.AddUserRequest;
import com.springboot.hobbyverse.model.User;

public interface UserRepository extends JpaRepository<User, Long>{
	Optional<User> findByEmail(String email); //유저의 계정(이메일)을 찾는 메서드
}
