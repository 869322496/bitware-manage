package com.qzy.service;

import com.qzy.bean.Classes;
import com.qzy.bean.Major;
import com.qzy.bean.MajorType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author qingzeyu
 */
public interface ClassService {
    List<Classes> getAllClassesByPage(@Param("pageStart") long pageStart , @Param("pageSize") long pageSize);
    int getTotalCount();
    int updateClass(Classes classes);
    Classes selectClassById(int id);
    List<MajorType> getAllMajorType();
    int deleteClassById(int id);
    int addClasses(Classes classes);
    List<Major> getAllMajorName();
}
