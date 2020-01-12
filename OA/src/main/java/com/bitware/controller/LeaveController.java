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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
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
     * @return
     */
    @RequestMapping("/auditLeave")
    @ResponseBody
    public BitResult auditLeave(@RequestBody List<LeaveAudit> leaveAudit){
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
     * @return
     */
    @RequestMapping("/isSameDay")
    @ResponseBody
    public BitResult isSameDay(@RequestBody JSONObject jsonObject){
        String userId = jsonObject.getString("userId");
        Long beginTime = jsonObject.getLongValue("beginTime");
        Long endTime = jsonObject.getLongValue("endTime");
        JSONObject returnData = new JSONObject();
        try {
         int sameDayNum =  leaveService.isSameDay(userId,new Date(beginTime),new Date(endTime)).size();
         if(sameDayNum  == 0){
             returnData.put("success",true);
             returnData.put("sameDayError",false);
             return BitResult.success(returnData);
         }  else{
             returnData.put("success",true);
             returnData.put("sameDayError",true);
             return BitResult.success(returnData);
         }

        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("获取失败！");
        }

    }

    /**
     *
     * @return
     */
    @RequestMapping("/getUserLeaveCountEchartData/{dateType}")
    @ResponseBody
    public BitResult getUserLeaveCountEchartData(@PathVariable String dateType){
        List<LeaveInfo> leaveInfoList;
        Date beginTime = new DateTime().toDate();
        Date endTime = new DateTime(new DateTime().getYear(),new DateTime().getMonthOfYear(),new DateTime().getDayOfMonth(),23,59,59,0).toDate();
        List<HashMap<String,Integer>>  echartDataSet;
        if(StringUtils.equals(dateType, ConstUtil.MONTH)){
            beginTime =  new DateTime().dayOfMonth().withMinimumValue().withMillisOfDay(0).toDate();//本月初
        }else if(StringUtils.equals(dateType, ConstUtil.YEAR)){
            beginTime = new DateTime().dayOfYear().withMinimumValue().withMillisOfDay(0).toDate();//本年初
        }
        try {
            echartDataSet = leaveService.getUserLeaveCountEchartData(beginTime,endTime);
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("获取失败！");
        }
        return BitResult.success(echartDataSet);
    }
}
