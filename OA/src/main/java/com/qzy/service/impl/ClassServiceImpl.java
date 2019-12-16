package com.qzy.service.impl;

import com.qzy.bean.Classes;
import com.qzy.bean.Major;
import com.qzy.bean.MajorType;
import com.qzy.mapper.ClassMapper;
import com.qzy.service.ClassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author qingzeyu
 */
@Service
public class ClassServiceImpl implements ClassService {
    @Autowired
    ClassMapper mapper;
    @Override
    public List<Classes> getAllClassesByPage(long pageStart, long pageSize) {
        return mapper.getAllClassesByPage(pageStart,pageSize);
    }

    @Override
    public int getTotalCount() {
        return mapper.getTotalCount();
    }

    @Override
    public int updateClass(Classes classes) {
        return mapper.updateClass(classes);
    }

    @Override
    public Classes selectClassById(int id) {
        return mapper.selectClassById(id);
    }

    @Override
    public List<MajorType> getAllMajorType() {
        return mapper.getAllMajorType();
    }

    @Override
    public int deleteClassById(int id) {
        return mapper.deleteClassById(id);
    }

    @Override
    public int addClasses(Classes classes) {
        return mapper.addClasses(classes);
    }

    @Override
    public List<Major> getAllMajorName() {
        return mapper.getAllMajorName();
    }
}
