package com.bitware.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bitware.bean.BitResult;
import com.bitware.bean.ResourceInfo;
import com.bitware.bean.UserInfo;
import com.bitware.service.impl.SecurityService;
import com.bitware.service.impl.ShareService;
import com.bitware.utils.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


import javax.annotation.Resource;
import javax.management.relation.RoleInfo;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

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

    @Autowired
    ShareService shareService;

    @RequestMapping("/verifylogin")
    @ResponseBody
    public BitResult verifylogin() {
        JSONObject initInfo = new JSONObject();
        JSONObject sys = new JSONObject();
        sys.put("appDescription", systemUtil.getAppDescription());
        sys.put("appName", systemUtil.getAppName());
        initInfo.put("app", sys);
        return BitResult.success(initInfo);
    }

    /**
     * 初始化平台信息
     *
     * @return
     */
    @RequestMapping("/initApp")
    @ResponseBody
    public BitResult initApp() {
        JSONObject initInfo = new JSONObject();
       /* JSONObject sys = new JSONObject();
        sys.put("appDescription",systemUtil.getAppDescription());
        sys.put("appName",systemUtil.getAppName());*/
        initInfo.put("app", systemUtil);
        initInfo.put("userInfo", BitUser.getCurrentUser());
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
            if (loginUser.getIsEnable() == 0) {
                return BitResult.failure("此用户被禁用！");
            }
            if (!StringUtils.equals(loginUser.getPassword(), jsonObject.getString("password"))) {
                return BitResult.failure("密码错误！");
            }
            String userAgent = request.getHeader("user-agent");
            String token = tokenUtil.generateToken(userAgent, userAccount);
            List<ResourceInfo> roleResource = shareService.getResourceByRoleId(loginUser.getRoleId(), "func", null);
            loginUser.setRoleResource(roleResource);
            tokenUtil.saveToken(token, loginUser);
            loginDto.put("userInfo", loginUser);
            loginDto.put("token", token);
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("登录失败！");
        }

        return BitResult.success(loginDto);
    }

    /**
     * 获取角色列表
     *
     * @return
     */
    @RequestMapping("/getRoleList")
    @ResponseBody
    public BitResult getRoleList() {
        return BitResult.success(securityService.getRoleList());
    }

    /**
     * 根据所有权限资源
     *
     * @return
     */
    @RequestMapping("/getResourceByCategory/{category}")
    @ResponseBody
    public BitResult getResourceByCategory(@PathVariable String category) {
        List<JSONObject> resources;
        try {
            JSONArray resourceTree = new JSONArray();
            JSONObject rootNode; //map太多泛型强转容易出错
            List<ResourceInfo> resourceInfoList = shareService.getResourceByRoleId(null, category, null);
            JSONArray resourceArray = JSONArray.parseArray(JSON.toJSONString(resourceInfoList));
            resources = JSONArray.parseObject(resourceArray.toString(), List.class);
            rootNode = resources.stream()
                    .filter(o -> StringUtils.equals(o.getString("parentId"), category.equals("func") ? TreeUtil.FUNCROOT : TreeUtil.MENUROOT))
                    .findAny()
                    .orElse(null);
            if (rootNode == null) {
                return BitResult.failure("没有根目录结构！");
            }
            TreeUtil.addTreeNode(rootNode, null, resources, resourceTree);
            return BitResult.success(resourceTree);
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("获取目录失败");
        }
    }

    /***
     * 根据roleId获取其拥有的资源
     * @param roleId
     * @return
     */
    @RequestMapping("/getResourceByRoleId/{roleId}/{category}")
    @ResponseBody
    public BitResult getResourceByRoleId(@PathVariable String roleId, @PathVariable String category) {
        return BitResult.success(shareService.getResourceByRoleId(roleId, category, null));
    }
}
