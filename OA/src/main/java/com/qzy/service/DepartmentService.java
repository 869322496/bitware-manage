package com.qzy.service;

import com.qzy.bean.Depart;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author qingzeyu
 */
public interface DepartmentService {
    int addDepartment(Depart depart);
    int deleteDepartment(int id);
    int getTotalCount();
    List<Depart> getDepartment(@Param("pageStart") long pageStart, @Param("pageSize") long pageSize);
    Depart selectDepartmentById(int id);
    int updateDepartment(Depart depart);
    List<Depart> findAllDepartment();
}
