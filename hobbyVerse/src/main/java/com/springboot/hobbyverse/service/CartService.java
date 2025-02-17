package com.springboot.hobbyverse.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.mapper.CartMapper;
import com.springboot.hobbyverse.model.Cart;

@Service
public class CartService {
	@Autowired
	private CartMapper cartMapper;
	
	public Cart selectCart(String id) {
		return this.cartMapper.selectCart(id);
	}
}
