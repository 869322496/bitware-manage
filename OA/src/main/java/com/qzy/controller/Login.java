package com.qzy.controller;

import com.qzy.bean.Depart;
import com.qzy.bean.Emp;
import com.qzy.bean.LoginLog;
import com.qzy.service.EmpService;
import com.qzy.service.LoginLogService;
import com.qzy.utils.LoginStatus;
import com.qzy.utils.PageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * @author qingzeyu
 */
@Controller
public class Login {
    @Autowired
    EmpService service;
    @Autowired
    LoginLogService loginLogService;
    @RequestMapping("/emp_login")
    @ResponseBody
    public LoginStatus emp_login(Emp emp, String ip,String cityAndAddress,HttpServletResponse response, HttpSession session) throws IOException {
        response. setContentType("text/html;charset=utf-8");
        LoginStatus message;
        Emp loginEmp = service.login(emp);
        if (loginEmp != null) {
            if (loginEmp.getFlag() == 1) {
                //登录成功去重定向首页
                //response.sendRedirect("index.jsp");
                //存session
                session.setAttribute("loginEmp",loginEmp);
                LoginLog loginLog = new LoginLog(ip, emp.getNo(), cityAndAddress);
                int i = loginLogService.addLoginLog(loginLog);
                System.out.println(i>0?"日志新增成功":"日志新增失败");
                message = new LoginStatus("登录成功",200);
            } else {
                //response.getWriter().write("<script>alert('账号已经被禁用，请联系管理员!');location.href='login.jsp';</script>");
                message = new LoginStatus( "账号已经被禁用，请联系管理员!",300);
            }
        } else {
            //response.getWriter().write("<script>alert('账号或密码错误!');location.href='login.jsp';</script>");
            message = new LoginStatus("账号或密码错误!",600);
        }
        return message;
    }
    @ResponseBody
    @RequestMapping("/getLoginlogs")
    public List<LoginLog> getLoginlogs(HttpSession session){
        return loginLogService.getLastLog(((Emp)session.getAttribute("loginEmp")).getNo());
    }
    @RequestMapping("/addEmp")
    @ResponseBody
    public LoginStatus addEmp(Emp emp){
        int i = service.addEmp(emp);
        System.out.println(emp);
        LoginStatus loginStatus = null;
        if (i > 0) {
            loginStatus = new LoginStatus("员工新增成功！",200);
        }else {
            loginStatus = new LoginStatus("员工新增失败！",300);
        }
        return loginStatus;
    }
    @ResponseBody
    @RequestMapping("/department_list")
    public List<Depart> showDepartmentList(HttpSession session){

        List<Depart> allDepart = service.findAllDepart();
        session.setAttribute("alldepart",allDepart);
        return allDepart;

    }

    @RequestMapping("/emp_list/{pageIndex}/{pageSize}")
    public String emp_list(@PathVariable("pageIndex") long pageIndex, @PathVariable("pageSize") long pageSize, Model model){
        int totalCount = service.getTotalCount();
        List<Emp> emp = service.getEmp((pageIndex - 1) * pageSize, pageSize);
        PageUtils pageUtils = new PageUtils(pageIndex,pageSize,totalCount,emp);
        model.addAttribute("pageUtils",pageUtils);
        return "emplist";
    }
    @RequestMapping("/update_Emp/{id}")
    public String update_Emp(@PathVariable("id") int id,Model model){
        Emp emp = service.selectEmpById(id);
        model.addAttribute("emp",emp);
        return "empupdate";
    }
    @RequestMapping("/update_emp")
    @ResponseBody
    public LoginStatus update_emp(Emp emp){
        LoginStatus loginStatus = null;
        System.out.println("-------------");
        System.out.println(emp);
        int i = service.updateEmp(emp);
        System.out.println(i);
        if (i > 0) {
            loginStatus = new LoginStatus("员工修改成功！",200);
        }else {
            loginStatus = new LoginStatus("员工修改失败！",300);
        }
        return loginStatus;
    }
@RequestMapping("/delete_emp")
@ResponseBody
    public LoginStatus delete_emp(int id){
        LoginStatus loginStatus = null;
    int i = service.deleteEmp(id);
    if (i > 0) {
        loginStatus = new LoginStatus("员工删除成功！",200);
    }else {
        loginStatus = new LoginStatus("员工删除失败！",300);
    }
    return loginStatus;
}


}
