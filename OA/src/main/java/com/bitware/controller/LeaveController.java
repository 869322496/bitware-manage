package com.bitware.controller;

import com.alibaba.fastjson.JSONObject;
import com.bitware.bean.BitResult;
import com.bitware.bean.LeaveAudit;
import com.bitware.bean.LeaveInfo;
import com.bitware.service.impl.LeaveService;
import com.bitware.utils.BitUser;
import com.bitware.utils.ConstUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.*;

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
     *
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
     *
     * @return
     */
    @RequestMapping("/getAuditLeave")
    @ResponseBody
    public BitResult getAuditLeave() {
        List<LeaveInfo> leaveInfoList;
        try {
            leaveInfoList = leaveService.getAuditLeaveByRoleId(BitUser.getCurrentUser().getRoleId());
            leaveInfoList.forEach(leave -> leave.setLeaveProcess(leaveService.getLeaveProcessByLeaveId(leave.getId())));
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("获取失败！");
        }
        return BitResult.success(leaveInfoList);
    }

    /**
     * 审核请假单
     *
     * @return
     */
    @RequestMapping("/auditLeave")
    @ResponseBody
    public BitResult auditLeave(@RequestBody List<LeaveAudit> leaveAudit) {
        List<LeaveInfo> leaveInfoList;
        try {
            leaveService.updateAuditLeave(leaveAudit);
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("获取失败！");
        }
        return BitResult.success("审核成功！");
    }

    /**
     * 异步校验时间是否重叠
     *
     * @return
     */
    @RequestMapping("/isSameDay")
    @ResponseBody
    public BitResult isSameDay(@RequestBody JSONObject jsonObject) {
        String userId = jsonObject.getString("userId");
        Long beginTime = jsonObject.getLongValue("beginTime");
        Long endTime = jsonObject.getLongValue("endTime");
        JSONObject returnData = new JSONObject();
        try {
            int sameDayNum = leaveService.isSameDay(userId, new Date(beginTime), new Date(endTime)).size();
            if (sameDayNum == 0) {
                returnData.put("success", true);
                returnData.put("sameDayError", false);
                return BitResult.success(returnData);
            } else {
                returnData.put("success", true);
                returnData.put("sameDayError", true);
                return BitResult.success(returnData);
            }

        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("获取失败！");
        }

    }

    /**
     * @return
     */
    @GetMapping("/getUserLeaveCountEchartData/{dateType}")
    @ResponseBody
    public BitResult getUserLeaveCountEchartData(@PathVariable String dateType) {
        List<LeaveInfo> leaveInfoList;
        Date beginTime = new DateTime().toDate();
        Date endTime = new DateTime(new DateTime().getYear(), new DateTime().getMonthOfYear(), new DateTime().getDayOfMonth(), 23, 59, 59, 0).toDate();
        List<Map<String, Float>> echartDataSet;
        if (StringUtils.equals(dateType, ConstUtil.MONTH)) {
            beginTime = new DateTime().dayOfMonth().withMinimumValue().withMillisOfDay(0).toDate();//本月初
        } else if (StringUtils.equals(dateType, ConstUtil.YEAR)) {
            beginTime = new DateTime().dayOfYear().withMinimumValue().withMillisOfDay(0).toDate();//本年初
        }
        try {
            echartDataSet = leaveService.getUserLeaveCountEchartData(beginTime, endTime);
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("获取失败！");
        }
        return BitResult.success(echartDataSet);
    }

    /**
     * 撤销申请
     *
     * @param leaveInfo
     * @return
     */
    @PostMapping("/cancelApply")
    @ResponseBody
    public BitResult cancelApply(@RequestBody LeaveInfo leaveInfo) {
        try {
            leaveService.deleteApply(leaveInfo);
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("撤销申请失败！请联系管理员！");
        }
        return BitResult.success("撤销申请成功！");
    }

    /**
     * 获取用户年假统计
     * 公式: 入职时间 a 剩余年假 b
     * b = (YearCount((now() - a) - 1year) + 5) - Day(事假、病假etc)
     * @param userId
     * @return
     * *annualLeaveSum : number 个人年假总数
     * *finishLeaveSum : number 个人已请并已完成请假总数
     * isOver: boolean 请加数量是否已超过拥有年假总数
     */
    @GetMapping("/getAnnualLeave/{userId}")
    @ResponseBody
    public BitResult  getAnnualLeave(@PathVariable String userId){
        List<Map<String, Object>> data;
        try {
            data   =  leaveService.getAnnualLeave(userId);
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("获取用户年假统计失败！请联系管理员！");
        }
        return BitResult.success(data);
    }

}
