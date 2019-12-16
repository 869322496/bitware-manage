package com.qzy.controller;

import com.qzy.bean.Classes;
import com.qzy.bean.Emp;
import com.qzy.bean.Student;
import com.qzy.service.StudentService;
import com.qzy.utils.ExcelUtils;
import com.qzy.utils.LoginStatus;
import com.qzy.utils.PageUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author qingzeyu
 */
@Controller
@Scope("prototype")
public class StudentController {
    @Autowired
    StudentService service;
    @RequestMapping("/student_list/{pageIndex}/{pageSize}")
    public String student_list(@PathVariable("pageIndex") Long pageIndex, @PathVariable("pageSize") Long pageSize, @RequestParam(value = "name", defaultValue = "") String name, @RequestParam(value = "class_id", defaultValue = "0") long class_id, Model model){
        HashMap<String, Object> map = new HashMap<>();
        map.put("pageStart",(pageIndex-1)*pageSize);
        map.put("pageSize",pageSize);
        map.put("class_id",class_id);
        map.put("name","%"+name+"%");
        int totalCount = service.getTotalCount(map);
        List<Student> studentByPage = service.getStudentByPage(map);
        PageUtils pageUtils=new PageUtils(pageIndex,pageSize,totalCount,studentByPage);
        model.addAttribute("pageUtils",pageUtils);
        model.addAttribute("name",name);
        model.addAttribute("class_id",class_id);
        return "studentlist";
    }
    @RequestMapping("/student_getClasses")
    @ResponseBody
    public List<Classes> student_getClasses(){
        return service.getAllClasses();
    }

    @RequestMapping("/student_exportExcel")
    public void exportExcel(@RequestParam(value = "name",defaultValue = "") String name, @RequestParam(value = "class_id",defaultValue = "0") long class_id, HttpServletResponse response){
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("class_id",class_id);
        map.put("name","%"+name+"%");
        List<Student> students = service.getExcelStudents(map);
        //要导出的数据
        String [][] content = new String[students.size()][8];
        for (int i = 0; i <students.size() ; i++) {
            Student s = students.get(i);
            content[i][0]=String.valueOf(s.getId());
            content[i][1]=String.valueOf(s.getNo());
            content[i][2]=String.valueOf(s.getName());
            content[i][3]=String.valueOf(s.getSex());
            content[i][4]=String.valueOf(s.getEmail());
            content[i][5]=String.valueOf(s.getPhone());
            content[i][6]=String.valueOf(s.getClasses().getClassName());
            content[i][7]=String.valueOf(s.getSchool());
        }

        String[] title={"序号","学号","姓名","性别","邮箱","电话","班级","学校"};
        //需要把查询到的集合中的数据，生成一个Excel表格，然后响应给用户！
        HSSFWorkbook wb = ExcelUtils.getHSSFWorkbook("学生信息统计", title, content);
        //生成Excel
        //响应到客户端
        try {
            //excel文件名
            String fileName = "学生信息表" + System.currentTimeMillis() + ".xls";
            this.setResponseHeader(response, fileName);
            OutputStream os = response.getOutputStream();
            wb.write(os);//响应给客户端
            os.flush();
            os.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 发送响应流方法
     */
    public void setResponseHeader(HttpServletResponse response, String fileName) {
        try {
            try {
                fileName = new String(fileName.getBytes(), "ISO8859-1");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            response.setContentType("application/octet-stream;charset=ISO8859-1");
            response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
            response.addHeader("Pargam", "no-cache");
            response.addHeader("Cache-Control", "no-cache");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
    @RequestMapping("/update_student")
    @ResponseBody
    public LoginStatus update_student(Student student){
        LoginStatus loginStatus = null;
        int i = service.updateStudent(student);
        if (i > 0) {
            loginStatus = new LoginStatus("学生修改成功", 200);
        }else {
            loginStatus = new LoginStatus("学生修改失败",300);
        }
        return loginStatus;
    }
    @RequestMapping("/update_Student/{id}")
    public String update_Student(@PathVariable("id") int id,Model model){
        Student student = service.selectStudentById(id);
        model.addAttribute("student",student);
        return "studentupdate";
    }
    @RequestMapping("/add_student")
    @ResponseBody
    public LoginStatus add_student(Student student){
        LoginStatus loginStatus = null;
        int i = service.addStudent(student);
        if (i > 0) {
            loginStatus = new LoginStatus("学生新增成功", 200);
        }else {
            loginStatus = new LoginStatus("学生新增失败",300);
        }
        return loginStatus;
    }

    @RequestMapping("/delete_student")
    @ResponseBody
    public LoginStatus delete_student(int id){
        LoginStatus loginStatus = null;
        int i = service.deleteStudent(id);
        if (i > 0) {
            loginStatus = new LoginStatus("学生新增成功", 200);
        }else {
            loginStatus = new LoginStatus("学生新增失败",300);
        }
        return loginStatus;
}
    @RequestMapping("/student_importExcel")
    public void importExcel(Integer class_id, MultipartFile mFile, HttpServletResponse response) throws Exception {
        response.setContentType("text/html;charset=utf-8");
        System.out.println("要上传的Excel文件名是:" + mFile.getOriginalFilename());
        System.out.println("要上传的班级是:" + class_id);
        InputStream inputStream = mFile.getInputStream();
        HSSFWorkbook wb = new HSSFWorkbook(inputStream);
        HSSFSheet sheet = wb.getSheetAt(0);
        List<Student> students=new ArrayList<>();
        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
            Student s = new Student();
            HSSFRow row = sheet.getRow(i);
            if (row == null) {
                continue;
            }
            String cellStr = "";
            // 循环遍历单元格
            for (int j = 0; j < row.getLastCellNum(); j++) {
                HSSFCell cell = row.getCell(j);
                if (cell == null) {
                    cellStr = "";
                } else if (cell.getCellType() == HSSFCell.CELL_TYPE_BOOLEAN) {
                    cellStr = String.valueOf(cell.getBooleanCellValue());
                } else if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
                    cellStr = cell.getNumericCellValue() + "";
                } else {
                    cellStr = cell.getStringCellValue();
                }
                if (j == 0) {
                    s.setNo(cellStr);
                } else if (j == 1) {
                    s.setName(cellStr);
                }else if(j==2){
                    s.setSex(cellStr);
                }else if(j==3){
                    s.setEmail(cellStr);
                }else if(j==4){
                    s.setPhone(cellStr);
                }else if(j==5){
                    s.setClass_id(class_id);
                }else if(j==6){
                    s.setSchool(cellStr);
                }
            }
            System.out.println(s);
            students.add(s);
        }
        service.insertStudents(students);
        inputStream.close();
        response.getWriter().write("<script>alert('导入成功！');location.href='/student_list/1/5';</script>");

    }
    @RequestMapping("/student_details/{id}")
    public String student_details(@PathVariable("id") int id,Model model){
        Student studentById = service.getStudentById(id);
        model.addAttribute("studentById",studentById);
        return "studentdetails";
    }
}
