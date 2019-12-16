package com.qzy.controller;

import com.qzy.bean.Emp;
import com.qzy.bean.Users;
import com.qzy.service.EmpService;
import com.qzy.service.UsersService;
import com.qzy.utils.LoginStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * @author qingzeyu
 */
@Controller
public class UserController {
    @Autowired
    UsersService service;
    @Autowired
    EmpService empService;
    @RequestMapping("/showUserInfo/{id}")
    public String showUserInfo(@PathVariable("id") int id, Model model){
        Users users = service.selectUserInfoById(id);
        System.out.println(users);
        model.addAttribute("user",users);
        return "userInfo";
    }
    @RequestMapping("/showUserPhoto/{id}")
    public String showUserPhoto(@PathVariable("id") int id, Model model){
        Users users = service.selectUserInfoById(id);
        model.addAttribute("user",users);
        return "photo";
    }

    @RequestMapping("/user_changePhoto")
    @ResponseBody
   public LoginStatus user_changePhoto(Emp emp,HttpSession session) {
        LoginStatus loginStatus = null;
        int i = service.updateUserPhotoById(emp);
        Emp emp1 = empService.selectEmpById((int) emp.getId());
        session.setAttribute("loginEmp",emp1);
        if (i > 0) {
            loginStatus = new LoginStatus("头像修改成功", 200);
        }else {
            loginStatus = new LoginStatus("头像修改失败",300);
        }
        return loginStatus;
    }
    @RequestMapping("/user_loginOut")
    public void user_loginOut(HttpServletResponse response) throws IOException {
        response.getWriter().write("<script>parent.location.href='http://localhost:8080';</script>");
    }
    @RequestMapping("/updateUserPassword")
    @ResponseBody
    public LoginStatus updateUserPassword(Emp emp){
        LoginStatus loginStatus = null;
        System.out.println(emp);
        if (emp.getPass().equals(emp.getEmail())) {
            int i = service.updateUserPhotoById(emp);
            System.out.println(i);
            if (i > 0) {
                loginStatus = new LoginStatus("密码修改成功", 200);
            }else {
                loginStatus = new LoginStatus("密码修改失败",300);
            }
            return loginStatus;
        }else{
            loginStatus = new LoginStatus("新密码输入不一致",300);
            return loginStatus;
        }
    }
}
