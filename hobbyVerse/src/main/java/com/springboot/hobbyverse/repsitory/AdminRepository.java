package com.springboot.hobbyverse.repsitory;

import org.springframework.data.jpa.repository.JpaRepository;

import com.springboot.hobbyverse.model.Admin;

public interface AdminRepository extends JpaRepository<Admin, Long> {
	Admin findByEmail(String email);
}
