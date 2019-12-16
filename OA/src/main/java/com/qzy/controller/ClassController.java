package com.qzy.controller;

import com.qzy.bean.Classes;
import com.qzy.bean.Major;
import com.qzy.bean.MajorType;
import com.qzy.service.ClassService;
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
public class ClassController {
    @Autowired
    ClassService service;
    @RequestMapping("/class_list/{pageIndex}/{pageSize}")
    public String class_list(@PathVariable("pageIndex") long pageIndex, @PathVariable("pageSize") long pageSize, Model model){
        List<Classes> allClassesByPage = service.getAllClassesByPage((pageIndex - 1) * pageSize, pageSize);
        int totalCount = service.getTotalCount();
        List<Major> allMajorName = service.getAllMajorName();
        System.out.println(allClassesByPage);
        model.addAttribute("allMajorName",allMajorName);
        PageUtils pageUtils = new PageUtils(pageIndex,pageSize,totalCount,allClassesByPage);
        model.addAttribute("pageUtils",pageUtils);
        return "gradelist";
    }
    @RequestMapping("/update_Class/{id}")
    public String update_Class(@PathVariable("id") int id,Model model){
        Classes classes = service.selectClassById(id);
        List<Major> allMajorName = service.getAllMajorName();
        model.addAttribute("allMajorName",allMajorName);
        model.addAttribute("classes",classes);
        return "gradeupdate";
    }
    @RequestMapping("/update_class")
    @ResponseBody
    public LoginStatus update_class(Classes classes){
        System.out.println(classes);
        LoginStatus loginStatus = null;
        int i = service.updateClass(classes);
        System.out.println(i);
        if (i > 0) {
            loginStatus = new LoginStatus("班级修改成功", 200);
        }else {
            loginStatus = new LoginStatus("班级修改失败",300);
        }
        return loginStatus;
    }
    @RequestMapping("/delete_class")
    @ResponseBody
    public LoginStatus delete_class(int id){
        LoginStatus loginStatus;
        int i = service.deleteClassById(id);
        if (i > 0) {
            loginStatus = new LoginStatus("班级删除成功", 200);
        }else {
            loginStatus = new LoginStatus("班级删除失败",300);
        }
        return loginStatus;
    }
    @RequestMapping("/getClasses_list")
    public String  getClasses_list(Model model){
        List<Major> allMajorName = service.getAllMajorName();
        model.addAttribute("allMajorName",allMajorName);
        return "gradeadd";
    }
    @RequestMapping("/add_class")
    @ResponseBody
    public LoginStatus addClass(Classes classes){
        System.out.println(classes);
        LoginStatus loginStatus;
        int i = service.addClasses(classes);
        if (i > 0) {
            loginStatus = new LoginStatus("班级新增成功", 200);
        }else {
            loginStatus = new LoginStatus("班级新增失败",300);
        }
        return loginStatus;
    }
}
