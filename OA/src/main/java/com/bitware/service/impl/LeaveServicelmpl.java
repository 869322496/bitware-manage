package com.bitware.service.impl;

import com.bitware.bean.LeaveAudit;
import com.bitware.bean.LeaveInfo;
import com.bitware.mapper.LeaveMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LeaveServicelmpl implements LeaveService {
    @Autowired
    LeaveMapper leaveMapper;

    @Override
    public List<LeaveInfo> getLeaveById(String id) {
        return leaveMapper.getLeaveById(id);
    }

    @Override
    public List<LeaveInfo> getLeaveByUserId(String userId) {
        return leaveMapper.getLeaveByUserId(userId);
    }

    @Override
    public void insertLeave(LeaveInfo leave) {
        leaveMapper.insertLeave(leave);
    }

    @Override
    public List<LeaveAudit> getLeaveProcessByLeaveId(String leaveId) {
        return leaveMapper.getLeaveProcessByLeaveId(leaveId);
    }
}
