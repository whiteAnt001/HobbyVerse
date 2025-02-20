package com.springboot.hobbyverse.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.hobbyverse.model.Cart;

@Mapper
public interface CartMapper {
	public Cart selectCart(String id);
}
