package com.bitware.service.impl;

import com.bitware.bean.DictionaryItem;
import com.bitware.bean.LeaveAudit;
import com.bitware.bean.LeaveInfo;
import com.bitware.mapper.LeaveMapper;
import com.bitware.mapper.ShareMapper;
import com.bitware.utils.BitUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class LeaveServicelmpl implements LeaveService {
    @Autowired
    LeaveMapper leaveMapper;
    @Autowired
    ShareMapper shareMapper;

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
    public List<LeaveInfo> getAuditLeaveByRoleId(String roleId) {
        return leaveMapper.getAuditLeaveByRoleId(roleId);
    }

    @Override
    @Transactional
    public void updateAuditLeave(List<LeaveAudit> leaveAudits) {
        leaveAudits.forEach(audit -> {
            LeaveInfo auditLeave = leaveMapper.getLeaveById(audit.getLeaveId());
            audit.setAuditor(BitUser.getCurrentUser().getId());
            audit.setTime(new Date());
            leaveMapper.updateAudit(audit);//更新步骤
            if (audit.getStatus() == 1) {//步骤同意
                //若前端处理得当不会出现这种情况，传过来的都是未同意的)
                List<DictionaryItem> auditProcess = shareMapper.getDictionary("AuditType", "all");
                //继续下一流程，获取当前流程序号
                int currentNo = auditProcess.stream()
                        .map(DictionaryItem::getCode)
                        .collect(Collectors.toList())
                        .indexOf(audit.getType());
                //判断是否为最终流程
                DictionaryItem finishStatus = shareMapper.getDictionary("LeaveStatus", "LeaveStatusAgree").get(0);
                if (currentNo == auditProcess.size() - 1 ) {
                    //最终流程则同意请假单
                    auditLeave.setStatus(Integer.parseInt(finishStatus.getData()));
                } else {
                    //不是最终流程则新增下一环节审核单
                    auditLeave.setStatus(currentNo + 1);
                    LeaveAudit nextAudit = new LeaveAudit();
                    nextAudit.setType(auditProcess.get(currentNo + 1).getCode());
                    nextAudit.setStatus(0);
                    nextAudit.setLeaveId(audit.getLeaveId());
                    leaveMapper.insertAudit(nextAudit);
                }
            }else{//拒绝直接结束请假流程
                DictionaryItem endStatus = shareMapper.getDictionary("LeaveStatus", "LeaveStatusRefuse").get(0);
                auditLeave.setStatus(Integer.parseInt(endStatus.getData()));
            }
            leaveMapper.updateLeave(auditLeave);
        });
    }

    @Override
    public List<LeaveInfo> isSameDay(String userId, Date beginTime, Date endTime) {
       return  leaveMapper.isSameDay(userId,beginTime,endTime);
    }

    @Override
    public List<HashMap<String, Integer>> getUserLeaveCountEchartData(Date beginTime, Date endTime) {
        return leaveMapper. getUserLeaveCountEchartData(beginTime,endTime);
    }
}
