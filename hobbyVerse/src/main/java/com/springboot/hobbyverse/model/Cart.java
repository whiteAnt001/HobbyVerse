package com.springboot.hobbyverse.model;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.hobbyverse.service.CartService;

import lombok.Getter;
import lombok.Setter;

@Service
@Getter
@Setter
public class Cart {
	@Autowired
	private CartService cartService;
	private String id;
	private Integer code;
	private Integer num;
	
	private ArrayList<Integer> codeList = new ArrayList<Integer>();
	private ArrayList<Integer> numList = new ArrayList<Integer>();
	
	public void clearAll() {
		this.codeList = new ArrayList<Integer>();
		this.numList = new ArrayList<Integer>();
				
	}
	
	public void setCodeList(int index, Integer code) {
		this.codeList.add(index, code);
	}
	
	public void setNumList(int index, Integer num) {
		this.numList.add(index, num);
	}
	
	
}
