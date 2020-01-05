package com.bitware.service.impl;

import com.bitware.bean.LeaveInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LeaveService {

    List<LeaveInfo> getLeaveById(String id);

    List<LeaveInfo> getLeaveByUserId(@Param("userId") String userId);

    void insertLeave(LeaveInfo leave);
}
