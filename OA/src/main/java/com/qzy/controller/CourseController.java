package com.qzy.controller;


import com.qzy.bean.Major;
import com.qzy.bean.MajorType;
import com.qzy.service.MajorService;
import com.qzy.utils.LoginStatus;
import com.qzy.utils.PageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author qingzeyu
 */
@Controller
public class CourseController {
    @Autowired
    MajorService service;
    @RequestMapping("/course_list/{pageIndex}/{pageSize}")
    public String course_list(@PathVariable("pageIndex") long pageIndex, @PathVariable("pageSize") long pageSize, Model model){
        int totalCount = service.getTotalCount();
        List<Major> allMajor = service.findAllMajor((pageIndex - 1) * pageSize, pageSize);
        PageUtils pageUtils = new PageUtils(pageIndex,pageSize,totalCount,allMajor);
        model.addAttribute("pageUtils",pageUtils);
        return "courselist";
    }
    @RequestMapping("/update_Course/{id}")
    public String  update_Course(@PathVariable("id") int id,Model model){
        Major major = service.selectMajorById(id);
        List<MajorType> allMajorType = service.findAllMajorType();
        model.addAttribute("allmajortype",allMajorType);
        model.addAttribute("major",major);
        return "courseupdate";
    }
   /* @RequestMapping("/showMajorType")
    public List<MajorType> showMajorType(Model model){
        List<MajorType> allMajorType = service.findAllMajorType();
        model.addAttribute("allmajortype",allMajorType);
        return allMajorType;
    }*/
    @RequestMapping("/update_course")
    @ResponseBody
    public LoginStatus update_course(Major major){
        LoginStatus loginStatus = null;
        System.out.println(major);
        int i = service.updateMajor(major);
        if (i > 0) {
            loginStatus = new LoginStatus("专业修改成功", 200);
        }else {
            loginStatus = new LoginStatus("专业修改失败",300);
        }
        return loginStatus;
    }
    @RequestMapping("/delete_course")
    @ResponseBody
    public LoginStatus delete_course(int id){
        LoginStatus loginStatus = null;
        int i = service.deleteMajor(id);
        if (i > 0) {
            loginStatus = new LoginStatus("专业删除成功", 200);
        }else {
            loginStatus = new LoginStatus("专业删除失败",300);
        }
        return loginStatus;
    }
    @RequestMapping("/add_Course")
    public String addCourse(Model model){
        List<MajorType> allMajorType = service.findAllMajorType();
        System.out.println(allMajorType);
        model.addAttribute("allMajorType",allMajorType);
        return "courseadd";
    }
    @RequestMapping("/add_course")
    @ResponseBody
    public LoginStatus addCourse(Major major){
        LoginStatus loginStatus;
        int i = service.addMajor(major);
        if (i > 0) {
            loginStatus = new LoginStatus("专业新增成功", 200);
        }else {
            loginStatus = new LoginStatus("专业新增失败",300);
        }
        return loginStatus;
    }
}
