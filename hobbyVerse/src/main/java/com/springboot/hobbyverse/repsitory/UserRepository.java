package com.springboot.hobbyverse.repsitory;


import org.springframework.data.jpa.repository.JpaRepository;
import com.springboot.hobbyverse.model.User;

public interface UserRepository extends JpaRepository<User, Long>{
	User findByEmail(String email);
}
