package com.qzy.service.impl;

import com.qzy.bean.Major;
import com.qzy.bean.MajorType;
import com.qzy.mapper.MajorMapper;
import com.qzy.service.MajorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author qingzeyu
 */
@Service
public class MajorServiceImpl implements MajorService {
    @Autowired
    MajorMapper mapper;
    @Override
    public int getTotalCount() {
        return mapper.getTotalCount();
    }

    @Override
    public List<Major> findAllMajor(long pageStart, long pageSize) {
        return mapper.findAllMajor(pageStart,pageSize);
    }

    @Override
    public Major selectMajorById(int id) {
        return mapper.selectMajorById(id);
    }

    @Override
    public List<MajorType> findAllMajorType() {
        return mapper.findAllMajorType();
    }

    @Override
    public int updateMajor(Major major) {
        return mapper.updateMajor(major);
    }

    @Override
    public int deleteMajor(int id) {
        return mapper.deleteMajor(id);
    }

    @Override
    public int addMajor(Major major) {
        return mapper.addMajor(major);
    }
}
