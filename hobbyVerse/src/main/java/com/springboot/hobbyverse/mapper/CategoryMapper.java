package com.springboot.hobbyverse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.hobbyverse.model.Category;
import com.springboot.hobbyverse.model.StartEnd;

@Mapper
public interface CategoryMapper {
	Integer getKeyCountByName(String title);
	List<Category> getKeyByName(StartEnd se);
}
