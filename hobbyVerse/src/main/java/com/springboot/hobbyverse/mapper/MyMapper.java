package com.springboot.hobbyverse.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.hobbyverse.model.User;


@Mapper
public interface MyMapper {
	User getUser(User user);
}
