package com.bitware.controller;

import com.alibaba.fastjson.JSONObject;
import com.bitware.bean.BitResult;
import com.bitware.bean.UserInfo;
import com.bitware.service.impl.SecurityService;
import com.bitware.utils.RedisUtil;
import com.bitware.utils.SystemUtil;
import com.bitware.utils.TokenUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import javax.servlet.http.HttpServletRequest;

/**
 * @author lu
 */
@Controller
@RequestMapping(value = "/security")
public class SecurityController {

    @Autowired
    SecurityService securityService;

    @Autowired
    RedisUtil redisUtil;

    @Autowired
    TokenUtil tokenUtil;

    @Autowired
    SystemUtil systemUtil;
    @RequestMapping("/verifylogin")
    @ResponseBody
    public BitResult verifylogin() {
        JSONObject initInfo = new JSONObject();
        JSONObject sys = new JSONObject();
        sys.put("appDescription",systemUtil.getAppDescription());
        sys.put("appName",systemUtil.getAppName());
        initInfo.put("app",sys);
        return BitResult.success(initInfo);
    }
    @RequestMapping("/initApp")
    @ResponseBody
    public BitResult login() {
        JSONObject initInfo = new JSONObject();
        JSONObject sys = new JSONObject();
        sys.put("appDescription",systemUtil.getAppDescription());
        sys.put("appName",systemUtil.getAppName());
        initInfo.put("app",sys);
        return BitResult.success(initInfo);
    }
    /**
     * 登录 此处后期集成shiro MD5加解密 redis session等
     *
     * @param jsonObject
     * @param request
     * @return
     */
    @RequestMapping("/login")
    @ResponseBody
    public BitResult login(@RequestBody JSONObject jsonObject, HttpServletRequest request) {
        UserInfo loginUser;
        JSONObject loginDto = new JSONObject();
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
            String userAgent = request.getHeader("user-agent");
            String token = tokenUtil.generateToken(userAgent, userAccount);
            tokenUtil.saveToken(token, loginUser);
            loginDto.put("userInfo",loginUser);
            loginDto.put("token",token);
            System.out.println(redisUtil.get(token));
        }catch (Exception e){
            e.printStackTrace();
            return BitResult.failure("登录失败！");
        }

        return BitResult.success(loginDto);
    }
}
