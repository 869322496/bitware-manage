package com.bitware.controller;

import com.alibaba.fastjson.JSONObject;
import com.bitware.bean.BitResult;
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
        }catch (Exception e){
            e.printStackTrace();
            return BitResult.failure("插入失败！");
        }
       return BitResult.success(leaveInfo);
    }

    @RequestMapping("/getLeaveById/{id}")
    @ResponseBody
    public BitResult getLeaveById(@PathVariable String id) {
        List<LeaveInfo> leaveInfoList;
        try {
            leaveInfoList =  leaveService.getLeaveById(id);
        }catch (Exception e){
            e.printStackTrace();
            return BitResult.failure("获取失败！");
        }
        return BitResult.success(leaveInfoList);
    }

    @RequestMapping("/getLeaveByUserId/{userId}")
    @ResponseBody
    public BitResult getLeaveByUserId(@PathVariable String userId) {
        List<LeaveInfo> leaveInfoList;
        try {
            leaveInfoList =  leaveService.getLeaveByUserId(userId);
        }catch (Exception e){
            e.printStackTrace();
            return BitResult.failure("获取失败！");
        }
        return BitResult.success(leaveInfoList);
    }
}
