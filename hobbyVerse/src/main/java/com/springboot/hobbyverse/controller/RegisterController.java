package com.springboot.hobbyverse.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.sym.Name;
import com.springboot.hobbyverse.model.Cart;
import com.springboot.hobbyverse.model.CartMeet;
import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.service.CartService;
import com.springboot.hobbyverse.service.MeetingService;
import com.springboot.hobbyverse.service.UserService;

import jakarta.servlet.http.HttpSession;


@Controller
public class RegisterController {
	@Autowired
	private UserService userService;
	@Autowired
	private CartService cartService;
	@Autowired
	private MeetingService meetingService;
	@Autowired
	private Cart cart;


	
	@PostMapping("/register/register")
	public ModelAndView register(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser");
		//로그인 정보 (로그인 되어있는지, 안되어있는지)
		if(user == null) {
			mav.setViewName("login");
			return mav;
		}
		Cart cart = (Cart)session.getAttribute("CART");
		if(cart == null) cart = this.cart;
		
		if(cart != null) {
			ArrayList<Integer> codeList = cart.getCodeList();
			ArrayList<Integer> numList = cart.getNumList();
			ArrayList<CartMeet> meetList = new ArrayList<CartMeet>();
			for(int i=0; i<codeList.size(); i++) {
				Integer code = codeList.get(i);
				Meetup meetup = this.meetingService.getMeet(code);
				User cartuser = this.userService.getUserInfo(user.getName());
				CartMeet cm = new CartMeet();
				cm.setM_id(meetup.getM_id());
				cm.setTitle(meetup.getTitle());
				cm.setInfo(meetup.getInfo());
				cm.setC_key(meetup.getC_key());
				cm.setW_date(meetup.getW_date());
				cm.setPrice(meetup.getPrice());
				cm.setW_id(meetup.getW_id());
				cm.setImagename(meetup.getImagename());
				cm.setName(cartuser.getName());
				cm.setEmail(cartuser.getEmail());
				
				meetList.add(cm);	
			}
			mav.addObject("MEETLIST", meetList);
		} else if(cart == null){
			mav.addObject("MEETLIST", null);
		}
		mav.setViewName("DetailGroupResult");
		return mav;
	}
	
}
