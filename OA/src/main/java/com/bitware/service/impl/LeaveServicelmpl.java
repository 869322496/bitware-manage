package com.bitware.service.impl;

import com.bitware.bean.LeaveAudit;
import com.bitware.bean.LeaveInfo;
import com.bitware.mapper.LeaveMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class LeaveServicelmpl implements LeaveService {
    @Autowired
    LeaveMapper leaveMapper;

    @Override
    public LeaveInfo getLeaveById(String id) {
        return leaveMapper.getLeaveById(id);
    }

    @Override
    public List<LeaveInfo> getLeaveByUserId(String userId) {
        return leaveMapper.getLeaveByUserId(userId);
    }

    @Override
    @Transactional
    public void insertLeave(LeaveInfo leave) {
        leaveMapper.insertLeave(leave);
        LeaveAudit leaveAudit = new LeaveAudit();
        leaveAudit.setLeaveId(leave.getId());
        leaveAudit.setType("DepartmentAudit");
        leaveAudit.setStatus(0);
        leaveMapper.insertAudit(leaveAudit);
    }
    @Override
    public List<LeaveAudit> getLeaveProcessByLeaveId(String leaveId) {
        return leaveMapper.getLeaveProcessByLeaveId(leaveId);
    }

    @Override
    public List<LeaveInfo> getLeaveByRoleId(String roleId) {
        return leaveMapper.getLeaveByRoleId(roleId);
    }

    @Override
    public void auditLeave(List<LeaveAudit> leaveAudits) {
        leaveAudits.forEach(item->{
            

            LeaveInfo leaveInfo = leaveMapper.getLeaveById(leaveId);
        });


        return null;
    }
}
