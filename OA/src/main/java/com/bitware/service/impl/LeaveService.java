package com.bitware.service.impl;

import com.bitware.bean.LeaveAudit;
import com.bitware.bean.LeaveInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LeaveService {

    List<LeaveInfo> getLeaveById(String id);

    List<LeaveInfo> getLeaveByUserId(String userId);

    void insertLeave(LeaveInfo leave);

    List<LeaveAudit> getLeaveProcessByLeaveId(String leaveId);
}
