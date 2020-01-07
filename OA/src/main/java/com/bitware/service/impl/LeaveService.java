package com.bitware.service.impl;

import com.bitware.bean.LeaveAudit;
import com.bitware.bean.LeaveInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LeaveService {

    LeaveInfo getLeaveById(String id);

    List<LeaveInfo> getLeaveByUserId(String userId);

    void insertLeave(LeaveInfo leave);

    List<LeaveAudit> getLeaveProcessByLeaveId(String leaveId);

    List<LeaveInfo> getLeaveByRoleId(String roleId);

    void auditLeave(List<LeaveAudit> leaveAudits);
}
