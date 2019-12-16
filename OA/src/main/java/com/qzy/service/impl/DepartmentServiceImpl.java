package com.qzy.service.impl;

import com.qzy.bean.Depart;
import com.qzy.mapper.DepartmentMapper;
import com.qzy.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author qingzeyu
 */
@Service
public class DepartmentServiceImpl implements DepartmentService {
    @Autowired
    DepartmentMapper mapper;
    @Override
    public int addDepartment(Depart depart) {
        return mapper.addDepartment(depart);
    }

    @Override
    public int deleteDepartment(int id) {
        return mapper.deleteDepartment(id);
    }

    @Override
    public int getTotalCount() {
        return mapper.getTotalCount();
    }

    @Override
    public List<Depart> getDepartment(long pageStart, long pageSize) {
        return mapper.getDepartment(pageStart,pageSize);
    }

    @Override
    public Depart selectDepartmentById(int id) {
        return mapper.selectDepartmentById(id);
    }

    @Override
    public int updateDepartment(Depart depart) {
        return mapper.updateDepartment(depart);
    }

    @Override
    public List<Depart> findAllDepartment() {
        return mapper.findAllDepartment();
    }
}
