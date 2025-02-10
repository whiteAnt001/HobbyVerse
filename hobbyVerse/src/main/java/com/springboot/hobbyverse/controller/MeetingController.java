package com.springboot.hobbyverse.controller;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.hobbyverse.model.Meetup;
import com.springboot.hobbyverse.service.MeetingService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MeetingController {

    @Autowired 
    private MeetingService meetingService;


    @GetMapping(value = "/meetup/index.html")
    public ModelAndView index() {
        ModelAndView mav = new ModelAndView("home");
        List<Meetup> meetList = this.meetingService.getMeetList();
        mav.addObject("meetList", meetList);
        return mav;
    }

    @GetMapping(value = "/meetup/createGroup.html")
    public ModelAndView entry() {
        List<Object[]> categoryList = meetingService.getCategoryList();
        ModelAndView mav = new ModelAndView("createGroup");
        mav.addObject(new Meetup());
        mav.addObject("categoryList", categoryList);
        return mav;
    }

    @PostMapping("/meetup/register.html")
    public ModelAndView register(Meetup meetup, BindingResult br, HttpSession session, 
                HttpServletRequest request) throws Exception {
        MultipartFile multiFile = meetup.getFile();
        String fileName = null;
        String path = null;
        OutputStream out = null;
        fileName = multiFile.getOriginalFilename();
        if(! fileName.equals("")) {
            ServletContext ctx = session.getServletContext();
            path = ctx.getRealPath("/upload/"+fileName);
            BufferedInputStream bis = null;
            try {
                out = new FileOutputStream(path);
                bis = new BufferedInputStream(multiFile.getInputStream());
                byte[] buffer = new byte[8192];
                int read = 0;
                while((read = bis.read()) > 0) {
                    out.write(buffer, 0, read);
                }
            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if(out != null) out.close();
                    if(bis != null) bis.close();
                } catch(Exception e) {}
            }
            meetup.setImagename(fileName);
        }
        this.meetingService.putMeeting(meetup);
        ModelAndView mav = new ModelAndView("createGroupDone");
        mav.addObject("message", "모임이 등록되었습니다.");
        return mav;
    }



    @GetMapping(value = "/meetup/detail/{id}.html")
    public ModelAndView detail(@PathVariable Integer id) {
        ModelAndView mav = new ModelAndView("meetingDetail");
        Meetup meetings = this.meetingService.getMeetDetail(id);
        mav.addObject("meetings", meetings);
        return mav;
    }
}
