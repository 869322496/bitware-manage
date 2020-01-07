package com.bitware.mapper;

import com.bitware.bean.LeaveAudit;
import com.bitware.bean.LeaveInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LeaveMapper {

    LeaveInfo getLeaveById(@Param("id") String id);

    List<LeaveInfo> getLeaveByUserId(@Param("userId") String userId);

    void insertLeave(LeaveInfo leave);

    void insertAudit(LeaveAudit leaveAudit);

    List<LeaveAudit> getLeaveProcessByLeaveId(@Param("leaveId") String leaveId);

    List<LeaveInfo> getLeaveByRoleId(@Param("roleId") String roleId);
}
