package com.bitware.service.impl;

import com.bitware.bean.LeaveAudit;
import com.bitware.bean.LeaveInfo;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface LeaveService {

    LeaveInfo getLeaveById(String id);

    List<LeaveInfo> getLeaveByUserId(String userId);

    void insertLeave(LeaveInfo leave);

    List<LeaveAudit> getLeaveProcessByLeaveId(String leaveId);

    List<LeaveInfo> getAuditLeaveByRoleId(String roleId);

    void updateAuditLeave(List<LeaveAudit> leaveAudits);

    List<LeaveInfo> isSameDay(String userId, Date beginTime, Date endTime);

    List<Map<String, Float>> getUserLeaveCountEchartData(Date beginTime, Date endTime);

    void deleteApply(LeaveInfo leaveInfo);

    List<Map<String, Object>> getAnnualLeave(java.lang.String userId);

    void insertLeaveSupple(LeaveInfo leaveInfo);
}
