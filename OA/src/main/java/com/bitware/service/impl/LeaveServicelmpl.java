package com.bitware.service.impl;

import com.bitware.bean.*;
import com.bitware.mapper.LeaveMapper;
import com.bitware.mapper.SecurityMapper;
import com.bitware.mapper.ShareMapper;
import com.bitware.utils.BitUser;
import com.bitware.utils.ConstUtil;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.Years;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class LeaveServicelmpl implements LeaveService {
    @Autowired
    LeaveMapper leaveMapper;
    @Autowired
    ShareMapper shareMapper;
    @Autowired
    SecurityMapper securityMapper;

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
        leave.setStatus(0);
        leaveMapper.insertLeave(leave);
        LeaveAudit leaveAudit = new LeaveAudit();
        leaveAudit.setLeaveId(leave.getId());
        leaveAudit.setType("DepartmentAudit");
        leaveAudit.setStatus(0);
        leaveMapper.insertAudit(leaveAudit);
    }

    @Override
    @Transactional
    public void insertLeaveSupple(LeaveInfo leaveInfo) {
        DictionaryItem finishStatus = shareMapper.getDictionary("LeaveStatus", "LeaveStatusAgree").get(0);
        leaveInfo.setStatus(Integer.valueOf(finishStatus.getData()));//假单直接通过
        leaveMapper.insertLeave(leaveInfo);
        //这里其实是有问题的，补录的话应该需要审核权限才行。这版不做要求2020-01-17
        List<DictionaryItem> auditProcess = shareMapper.getDictionary("AuditType", "all");
        auditProcess.forEach(item->{//补录者拥有的审核权限流程直接通过，并产生流程下一不具备审核权限的流程点。
            LeaveAudit leaveAudit = new LeaveAudit();
            leaveAudit.setLeaveId(leaveInfo.getId());
            leaveAudit.setType(item.getCode());
            leaveAudit.setStatus(1);
            leaveAudit.setAuditor(BitUser.getCurrentUser().getId());
            leaveAudit.setTime(new Date());
            leaveAudit.setReason("补录直接通过");
            leaveInfo.setStatus(Integer.valueOf(item.getData()));
            leaveMapper.updateLeave(leaveInfo);
            leaveMapper.insertAudit(leaveAudit);
        });
     /*   List<ResourceInfo> allFunc = securityMapper.getResourceByRoleId(BitUser.getCurrentUser().getRoleId(), ConstUtil.FUNC, null);
        ResourceInfo leaveAuditFunc = securityMapper.getResourceByRoleId(BitUser.getCurrentUser().getRoleId(), ConstUtil.FUNC, "LeaveAuditPermesion").get(0);
        List<String> leaveAuditPermission = allFunc.stream().filter(item->StringUtils.equals(leaveAuditFunc.getId(),item.getParentId())).map(ResourceInfo::getCode).collect(Collectors.toList());
        auditProcess = auditProcess.stream().filter(item->leaveAuditPermission.contains(item.getCode())).collect(Collectors.toList());
        for (int i = 0; i < auditProcess.size() -1 ; i++) {
            DictionaryItem item = auditProcess.get(i);

        }


         ListIterator<DictionaryItem> listIterator = auditProcess.listIterator();
         while (listIterator.hasNext()){
            System.out.print(listIterator.next());
          }*/


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
                if (currentNo == auditProcess.size() - 1) {
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
            } else {//拒绝直接结束请假流程
                DictionaryItem endStatus = shareMapper.getDictionary("LeaveStatus", "LeaveStatusRefuse").get(0);
                auditLeave.setStatus(Integer.parseInt(endStatus.getData()));
            }
            leaveMapper.updateLeave(auditLeave);
        });
    }

    @Override
    public List<LeaveInfo> isSameDay(String userId, Date beginTime, Date endTime) {
        return leaveMapper.isSameDay(userId, beginTime, endTime);
    }

    @Override
    public List<Map<String, Float>> getUserLeaveCountEchartData(Date beginTime, Date endTime) {
        return leaveMapper.getUserLeaveCountEchartData(beginTime, endTime);
    }

    @Override
    @Transactional
    public void deleteApply(LeaveInfo leaveInfo) {//删除申请的同时 删除子流程
        /*    List<LeaveAudit> leaveAudits  =  leaveMapper.getLeaveProcessByLeaveId(leaveInfo.getId());*/
        //leaveMapper.deleteLeaveAudits(leaveAudits);
        leaveMapper.deleteLeaveAuditsByLeaveId(leaveInfo.getId());
        leaveMapper.deleteLeave(leaveInfo);
    }

    @Override
    public List<Map<String, Object>> getAnnualLeave(String userId) {
        List<Map<String, Object>> annualLeaveData = new ArrayList<>();
        //1.年假总数annualLeaveSum b = (YearCount((now() - a) - 1year) + 5) - Day(事假、病假)
        //当前年周期的开始时间、结束时间
        if (!Optional.ofNullable(userId).isPresent() || StringUtils.equals(userId, "all")) {
            List<UserInfo> allUser = securityMapper.getUserInfoByUserAccount(null);
            allUser.forEach(user ->
                    getUserAnnulLeaveDetail(annualLeaveData, user)
            );
        } else {
            getUserAnnulLeaveDetail(annualLeaveData, Optional.ofNullable(securityMapper.getUserInfoByUserId(userId)).orElse(new ArrayList<>()).get(0));
        }
        return annualLeaveData;
    }

    private void getUserAnnulLeaveDetail(List<Map<String, Object>> annualLeaveData, UserInfo user) {
        DateTime now = new DateTime();
        int betweenYear = Years.yearsBetween(new DateTime(user.getEntryTime()),now).getYears(); //相差几年
        Map<String,Object> noAnnualLeaveMap = new HashMap<>();
        Date endTime  = new DateTime(new DateTime().getYear(), new DateTime().getMonthOfYear(), new DateTime().getDayOfMonth(), 23, 59, 59, 0).toDate();
        Date beginTime;
        if (betweenYear < 1) {//若不满一年 无年假 全部该扣扣
            noAnnualLeaveMap.put("annualLeaveSum", 0f);
            beginTime = user.getEntryTime();
        } else {//大于1年的 取当前周期时间的请假计算 且年假总数会递增 初始为5
            int overOneYear = Years.yearsBetween( new DateTime(user.getEntryTime()).plusYears(1),now).getYears(); //相差几年
            BigDecimal temp1 = new BigDecimal(String.valueOf(overOneYear));
            BigDecimal baseYear = new BigDecimal("5");
            noAnnualLeaveMap.put("annualLeaveSum", temp1.add(baseYear).floatValue());
            beginTime = new DateTime(user.getEntryTime()).plusYears(overOneYear + 1).toDate();
        }
        Float finishLeaveSum = leaveMapper.getFinishAnnualLeaveCount(user.getId(), beginTime, endTime);
        noAnnualLeaveMap.put("finishLeaveSum", Optional.ofNullable(finishLeaveSum).orElse(0f));
        noAnnualLeaveMap.put("userId",user.getId());
        noAnnualLeaveMap.put("name",user.getName());
        annualLeaveData.add(noAnnualLeaveMap);
    }
}
