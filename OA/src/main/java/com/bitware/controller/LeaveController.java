package com.bitware.controller;

import com.alibaba.fastjson.JSONObject;
import com.bitware.bean.BitResult;
import com.bitware.bean.LeaveAudit;
import com.bitware.bean.LeaveInfo;
import com.bitware.service.impl.LeaveService;
import com.bitware.utils.BitUser;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author lu
 */
@Controller
@RequestMapping(value = "/leave")
public class LeaveController {
    @Autowired
    LeaveService leaveService;

    /**
     * 生成假单
     * @param leaveInfo
     * @return
     */
    @RequestMapping("/insertLeave")
    @ResponseBody
    public BitResult insertLeave(@RequestBody LeaveInfo leaveInfo) {
        try {
            leaveService.insertLeave(leaveInfo);
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("插入失败！");
        }
        return BitResult.success(leaveInfo);
    }

    @RequestMapping("/getLeaveDetailById/{id}")
    @ResponseBody
    public BitResult getLeaveDetailById(@PathVariable String id) {
        LeaveInfo leaveInfo = new LeaveInfo();
        try {
            leaveInfo = leaveService.getLeaveById(id);
            //leaveInfoList.forEach(leave -> leave.setLeaveProcess(leaveService.getLeaveProcessByLeaveId(leave.getId())));
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("获取失败！");
        }
        return BitResult.success(leaveInfo);
    }

    /**
     *
     * @param userId
     * @return
     */
    @RequestMapping("/getLeaveDetailByUserId/{userId}")
    @ResponseBody
    public BitResult getLeaveDetailByUserId(@PathVariable String userId) {
        List<LeaveInfo> leaveInfoList;
        try {
            leaveInfoList = leaveService.getLeaveByUserId(userId);
            leaveInfoList.forEach(leave -> leave.setLeaveProcess(leaveService.getLeaveProcessByLeaveId(leave.getId())));

        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("获取失败！");
        }
        return BitResult.success(leaveInfoList);
    }

    /**
     * 获取当前登录角色权限审核的请假单
     * @return
     */
    @RequestMapping("/getAuditLeave")
    @ResponseBody
    public BitResult getAuditLeave(){
        List<LeaveInfo> leaveInfoList;
        try {
            leaveInfoList = leaveService.getLeaveByRoleId(BitUser.getCurrentUser().getRoleId());
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("获取失败！");
        }
        return BitResult.success(leaveInfoList);
    }

    /**
     * 获取当前登录角色权限审核的请假单
     * @return
     */
    @RequestMapping("/auditLeave")
    @ResponseBody
    public BitResult auditLeave(@RequestBody List<LeaveAudit> leaveAudit){
        List<LeaveInfo> leaveInfoList;
        try {
            leaveInfoList = leaveService.auditLeave(leaveAudit);
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("获取失败！");
        }
        return BitResult.success(leaveInfoList);
    }
}
