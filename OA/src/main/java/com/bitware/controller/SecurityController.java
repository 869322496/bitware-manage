package com.bitware.controller;

import com.alibaba.fastjson.JSONObject;
import com.bitware.bean.BitResult;
import com.bitware.bean.UserInfo;
import com.bitware.service.impl.SecurityService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * @author lu
 */
@Controller
@RequestMapping(value = "/security")
public class SecurityController {

    @Autowired
    SecurityService securityService;

    /**
     * 登录 此处后期集成shiro MD5加解密 redis session等
     *
     * @param jsonObject
     * @param session
     * @return
     */
    @RequestMapping("/login")
    @ResponseBody
    public BitResult login(@RequestBody JSONObject jsonObject, HttpSession session) {
        UserInfo loginUser;
        try {
            String userAccount = jsonObject.getString("userAccount");
            loginUser = securityService.getUserInfoByUserAccount(userAccount);
            if (loginUser == null || loginUser.getIsDelete() == 1) {
                return BitResult.failure("此用户不存在！");
            }
            if(loginUser.getIsEnable() == 0){
                return BitResult.failure("此用户被禁用！");
            }
            if(!StringUtils.equals(loginUser.getPassword(),jsonObject.getString("password"))){
                return BitResult.failure("密码错误！");
            }
        }catch (Exception e){
            e.printStackTrace();
            return BitResult.failure("登录失败！");
        }
        return BitResult.success(loginUser);
    }
}
