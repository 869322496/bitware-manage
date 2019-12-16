package com.qzy.mapper;

import com.qzy.bean.Major;
import com.qzy.bean.MajorType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author qingzeyu
 */
public interface MajorMapper {
    int getTotalCount();
    List<Major> findAllMajor(@Param("pageStart") long pageStart , @Param("pageSize") long pageSize);
    Major selectMajorById(int id);
    List<MajorType> findAllMajorType();
    int updateMajor(Major major);
    int deleteMajor(int id);
    int addMajor(Major major);
}
