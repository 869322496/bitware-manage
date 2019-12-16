package com.qzy.controller;

import com.qzy.bean.Depart;
import com.qzy.service.DepartmentService;
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
public class DepartmentController {
    @Autowired
    DepartmentService service;
    @RequestMapping("/add_Department")
    @ResponseBody
    public LoginStatus addDepartment(Depart depart){
    LoginStatus loginStatus = null;
        int i = service.addDepartment(depart);
        if (i > 0) {
            loginStatus = new LoginStatus("部门新增成功", 200);
        }else {
            loginStatus = new LoginStatus("部门新增失败",300);
        }
        return loginStatus;
    }
    @RequestMapping("/delete_Department")
    @ResponseBody
    public LoginStatus deleteDepartment(int id){
        LoginStatus loginStatus = null;
        int i = service.deleteDepartment(id);
        if (i > 0) {
            loginStatus = new LoginStatus("部门删除成功", 200);
        }else {
            loginStatus = new LoginStatus("部门删除失败",300);
        }
        return loginStatus;
    }

    @RequestMapping("/Department_list/{pageIndex}/{pageSize}")
    public String department_list(@PathVariable("pageIndex") long pageIndex, @PathVariable("pageSize") long pageSize, Model model){
        int totalCount = service.getTotalCount();
        List<Depart> department = service.getDepartment((pageIndex - 1) * pageSize , pageSize);
        PageUtils pageUtils = new PageUtils(pageIndex,pageSize,totalCount,department);
        model.addAttribute("pageUtils",pageUtils);
        return "departlist";
    }
    @RequestMapping("/update_Department/{id}")
    public String update_Department(@PathVariable int id,Model model){
        Depart depart = service.selectDepartmentById(id);
        model.addAttribute("depart",depart);
        return "departupdate";
    }
    @RequestMapping("/update_department")
    @ResponseBody
    public LoginStatus update_department(Depart depart){
        LoginStatus loginStatus = null;
        int i = service.updateDepartment(depart);
        if (i>0) {
            loginStatus = new LoginStatus("更新成功",200);
        }else {
            loginStatus = new LoginStatus("更新失败",300);
            System.out.println("更新失败");
        }
        return loginStatus;
    }
}
