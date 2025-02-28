package com.springboot.hobbyverse.repository;


import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.springboot.hobbyverse.model.User;
@Repository
public interface UserRepository extends JpaRepository<User, Long>{
	List<User> findAll();
	User findByEmail(String email);
	Optional<User> findByProviderAndProviderId(String provider, String providerId);
	User findByUserId(Long userId);
	void deleteByEmail(String email);
//	boolean existsByName(String name); //이름이 중복되는지 체크
	boolean existsByEmail(String email); //이메일이 중복되는지 체크
}
