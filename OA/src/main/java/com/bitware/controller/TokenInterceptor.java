package com.bitware.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.bitware.bean.BitResult;
import com.bitware.bean.UserInfo;
import com.bitware.utils.BitUser;
import com.bitware.utils.RedisUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TokenInterceptor implements HandlerInterceptor {
    @Autowired
    RedisUtil redisUtil;
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        String token  =request.getHeader("token");
        if(token != null){
         if(StringUtils.isNotEmpty(redisUtil.get(token))){
             // 已经登陆放行请求
             // 已登陆的用户加入线程当中
             BitUser.add(JSON.toJavaObject(JSON.parseObject(redisUtil.get(token)),UserInfo.class));
             BitUser.add(request);
            return true;
         }
        }
        response.setStatus(401);
        response.getWriter().write(JSONObject.toJSONString(BitResult.failure("认证失败")));
        return false;
    }
}
