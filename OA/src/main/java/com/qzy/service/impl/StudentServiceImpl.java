package com.qzy.service.impl;

import com.qzy.bean.Classes;
import com.qzy.bean.Emp;
import com.qzy.bean.Student;
import com.qzy.mapper.StudentMapper;
import com.qzy.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author qingzeyu
 */
@Service
public class StudentServiceImpl implements StudentService {
    @Autowired
    StudentMapper mapper;
    @Override
    public int getTotalCount(Map<String, Object> map) {
        return mapper.getTotalCount(map);
    }

    @Override
    public List<Student> getStudentByPage(Map<String, Object> map) {
        return mapper.getStudentByPage(map);
    }

    @Override
    public List<Classes> getAllClasses() {
        return mapper.getAllClasses();
    }

    @Override
    public List<Student> getExcelStudents(Map<String, Object> map) {
        return mapper.getExcelStudents(map);
    }

    @Override
    public int updateStudent(Student student) {
        return mapper.updateStudent(student);
    }

    @Override
    public Student selectStudentById(int id) {
        return mapper.selectStudentById(id);
    }

    @Override
    public int addStudent(Student student) {
        return mapper.addStudent(student);
    }

    @Override
    public int deleteStudent(int id) {
        return mapper.deleteStudent(id);
    }

    @Override
    public int insertStudents(List<Student> students) {
        return mapper.insertStudents(students);
    }

    @Override
    public Student getStudentById(int id) {
        return mapper.getStudentById(id);
    }
}
