package com.springboot.hobbyverse.repository;


import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import com.springboot.hobbyverse.model.User;

public interface UserRepository extends JpaRepository<User, Long>{
	User findByEmail(String email);
	Optional<User> findByProviderAndProviderId(String provider, String providerId);
}
