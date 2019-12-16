package com.qzy.service.impl;

import com.qzy.bean.Depart;
import com.qzy.bean.Emp;
import com.qzy.mapper.EmpMapper;
import com.qzy.service.EmpService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author qingzeyu
 */
@Service
public class EmpServiceImpl implements EmpService {
    @Resource
    EmpMapper mapper;
    @Override
    public Emp login(Emp emp) {
        return mapper.login(emp);
    }

    @Override
    public List<Depart> findAllDepart() {
        return mapper.findAllDepart();
    }

    @Override
    public int addEmp(Emp emp) {
        return mapper.addEmp(emp);
    }

    @Override
    public List<Emp> getEmp(long pageStart, long pageSize) {
        return mapper.getEmp(pageStart,pageSize);
    }

    @Override
    public int getTotalCount() {
        return mapper.getTotalCount();
    }

    @Override
    public int updateEmp(Emp emp) {
        return mapper.updateEmp(emp);
    }

    @Override
    public Emp selectEmpById(int id) {
        return mapper.selectEmpById(id);
    }

    @Override
    public int deleteEmp(int id) {
        return mapper.deleteEmp(id);
    }


}
