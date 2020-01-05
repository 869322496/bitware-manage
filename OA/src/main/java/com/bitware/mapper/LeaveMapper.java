package com.bitware.mapper;

import com.bitware.bean.LeaveInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LeaveMapper {

    List<LeaveInfo> getLeaveById(@Param("id") String id);

    List<LeaveInfo> getLeaveByUserId(@Param("userId") String userId);

    void insertLeave(LeaveInfo leave);


}
