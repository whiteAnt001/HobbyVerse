package com.springboot.hobbyverse.model;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Cart {
	private String id;//계정
	private String code;//모임 번호
	private Integer num;//모임 개수
	
	private ArrayList<String> codeList = new ArrayList<>();//모임 번호 목록
	private ArrayList<Integer> numList = new ArrayList<>();//모임 개수 목록
}
