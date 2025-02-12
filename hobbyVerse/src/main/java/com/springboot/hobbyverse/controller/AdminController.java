package com.springboot.hobbyverse.controller;

import java.time.format.DateTimeFormatter;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.User;
import com.springboot.hobbyverse.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private UserService userService;
    
    //관리자 전용 대시보드 경로
    @GetMapping("/dashboard")
    public ModelAndView dashboard() { // "deshboard" 오타 수정
        ModelAndView mav = new ModelAndView("dashboard");
        Integer userCount = this.userService.getUserCount();
        mav.addObject("totalUsers", userCount);
        return mav;
    }
    
    //맴버관리
    @GetMapping("/users")
    public ModelAndView userManagement() {
        ModelAndView mav = new ModelAndView("user_management"); 
        List<User> users = userService.getUserList();
     // 날짜 포맷 정의
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        System.out.println("검색 건수 :"+users.size());
        
        // 가입일을 문자열로 변환
        for (User user : users) {
        	System.out.println("regdate:"+user.getRegDate());
            if (user.getRegDate() != null) {
            	System.out.println("yes");
               // String formattedDate = user.getRegDate().format(formatter);
                System.out.println("가입일:["+user.getRegDate()+"]");
                //user.setRegDateString(formattedDate);
            } else {
            	System.out.println("else");
                user.setRegDateString("N/A"); // null 값 처리
            }
        }
        mav.addObject("users", users);
        return mav;
    }

    //모임 관리
    @GetMapping("/meetings")
    public ModelAndView meetingManagement() {
        ModelAndView mav = new ModelAndView("meeting_management");
        return mav;
    }
}
