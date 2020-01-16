package com.bitware.mapper;

import com.bitware.bean.LeaveAudit;
import com.bitware.bean.LeaveInfo;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    List<Map<String, Float>> getUserLeaveCountEchartData(@Param("beginTime") Date beginTime, @Param("endTime") Date endTime);

    void deleteLeave(LeaveInfo leaveInfo);

    //void deleteLeaveAudits(@Param("leaveAudits")List<LeaveAudit> leaveAudits);

    void deleteLeaveAuditsByLeaveId(@Param("id") String id);

    Float getFinishAnnualLeaveCount(@Param("userId")String userId, @Param("beginTime")Date beginTime,@Param("endTime") Date endTime);
}
