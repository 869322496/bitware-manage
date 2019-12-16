package com.qzy.mapper;

import com.qzy.bean.Depart;
import com.qzy.bean.Emp;
import com.qzy.bean.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author qingzeyu
 */
public interface EmpMapper {
    Emp login(Emp emp);
    List<Depart> findAllDepart();
    List<Student> findAllStudent();
    int addEmp(Emp emp);
    List<Emp> getEmp(@Param("pageStart") long pageStart , @Param("pageSize") long pageSize);
    int getTotalCount();
    int updateEmp(Emp emp);
    Emp selectEmpById(int id);
    int deleteEmp(int id);
}
