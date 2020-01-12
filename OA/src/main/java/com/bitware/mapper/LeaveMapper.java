package com.bitware.mapper;

import com.bitware.bean.LeaveAudit;
import com.bitware.bean.LeaveInfo;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

public interface LeaveMapper {

    LeaveInfo getLeaveById(@Param("id") String id);

    List<LeaveInfo> getLeaveByUserId(@Param("userId") String userId);

    void insertLeave(LeaveInfo leave);

    void insertAudit(LeaveAudit leaveAudit);

    List<LeaveAudit> getLeaveProcessByLeaveId(@Param("leaveId") String leaveId);

    List<LeaveInfo> getAuditLeaveByRoleId(@Param("roleId") String roleId);

    void updateLeave(LeaveInfo leave);

    void updateAudit(LeaveAudit leaveAudit);

    List<LeaveInfo> isSameDay(@Param("userId") String userId, @Param("beginTime") Date beginTime, @Param("endTime") Date endTime);

    List<HashMap<String, Integer>> getUserLeaveCountEchartData(@Param("beginTime") Date beginTime, @Param("endTime") Date endTime);
}
