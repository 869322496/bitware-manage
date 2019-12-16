package com.qzy.service;

import com.qzy.bean.Classes;
import com.qzy.bean.Emp;
import com.qzy.bean.Student;

import java.util.List;
import java.util.Map;

/**
 * @author qingzeyu
 */
public interface StudentService {
    int getTotalCount(Map<String,Object> map);
    List<Student> getStudentByPage(Map<String ,Object> map);
    List<Classes> getAllClasses();
    List<Student> getExcelStudents(Map<String ,Object> map);
    int updateStudent(Student student);
    Student selectStudentById(int id);
    int addStudent(Student student);
    int deleteStudent(int id);
    int insertStudents(List<Student> students);
    Student getStudentById(int id);
}
