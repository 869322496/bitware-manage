package com.bitware.controller;

import com.alibaba.fastjson.JSONObject;
import com.bitware.bean.BitResult;
import com.bitware.bean.LeaveAudit;
import com.bitware.bean.LeaveInfo;
import com.bitware.service.impl.LeaveService;
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
        List<LeaveInfo> leaveInfoList;
        try {
            leaveInfoList = leaveService.getLeaveById(id);
            leaveInfoList.forEach(leave -> leave.setLeaveProcess(leaveService.getLeaveProcessByLeaveId(leave.getId())));
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("获取失败！");
        }
        return BitResult.success(leaveInfoList);
    }

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
}
