package com.bitware.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bitware.bean.*;
import com.bitware.service.impl.SecurityService;
import com.bitware.service.impl.ShareService;
import com.bitware.utils.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Optional;

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
        List<ResourceInfo> funcResources = securityService.getResourceByRoleId(BitUser.getCurrentUser().getRoleId(), ConstUtil.FUNC, null);
        initInfo.put("userInfo", BitUser.getCurrentUser());
        initInfo.put("userAuth", funcResources);
        return BitResult.success(initInfo);
    }

    /**
     * 2019-12-30 登录 此处后期集成shiro MD5加解密 redis session等
     * 2020-01-08 redis已继承 session放弃改用token兼容移动端
     * param jsonObject
     *
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
            loginUser = securityService.getUserInfoByUserAccount(userAccount).stream().findFirst().orElse(null);
            if (!Optional.ofNullable(loginUser).isPresent() || loginUser.getIsDelete() == 1) {
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
            List<ResourceInfo> roleResource = securityService.getResourceByRoleId(loginUser.getRoleId(), "func", null);
            loginUser.setRoleResource(roleResource);
            loginUser.setToken(token);
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
            List<ResourceInfo> resourceInfoList = securityService.getResourceByRoleId(null, category, null);
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
        return BitResult.success(securityService.getResourceByRoleId(roleId, category, null));
    }

    /***
     * 插入更新角色资源
     * @return
     */
    @RequestMapping("/insertRoleResource")
    @ResponseBody
    public BitResult insertRoleResource(@RequestBody JSONObject jsonObject) {
        try {
            String roleId = jsonObject.getString("roleId");
            String category = jsonObject.getString("category");
            List<String> resourceIds = JSON.parseArray(jsonObject.getJSONArray("resourceIds").toJSONString(), String.class);
            securityService.insertRoleResource(roleId, category, resourceIds);
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("更新角色设置失败！");
        }
        return BitResult.success("更新角色设置成功！");
    }

    /**
     * 根据角色获取目录
     *
     * @param roleId
     * @return
     */
    @RequestMapping("/getMenu/{roleId}")
    @ResponseBody
    public BitResult getMenu(@PathVariable String roleId) {
        List<JSONObject> menuArray;
        try {
            JSONArray menu = new JSONArray();
            JSONObject rootNode; //map太多泛型强转容易出错
            List<ResourceInfo> resourceInfoList = securityService.getMenuByRoleId(roleId);
            JSONArray resourceArray = JSONArray.parseArray(JSON.toJSONString(resourceInfoList));
            menuArray = JSONArray.parseObject(resourceArray.toString(), List.class);
            rootNode = menuArray.stream()
                    .filter(o -> StringUtils.equals(o.getString("parentId"), TreeUtil.MENUROOT))
                    .findAny()
                    .orElse(null);
            if (rootNode == null) {
                return BitResult.failure("没有根目录结构！");
            }
            TreeUtil.addTreeNode(rootNode, null, menuArray, menu);
            return BitResult.success(menu);
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("获取目录失败");
        }
    }

    /**
     * 获取用户列表
     *
     * @return
     */
    @RequestMapping("/getUserList")
    @ResponseBody
    public BitResult getUserList() {
        return BitResult.success(securityService.getUserInfoByUserAccount(null));
    }

    /**
     * 新增用户
     *
     * @return
     */
    @PostMapping("/insertUser")
    @ResponseBody
    public BitResult insertUser(@RequestBody UserInfo userInfo) {
        try {
            securityService.insertUser(userInfo);
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("新增用户失败！");
        }
        return BitResult.success("新增用户成功！");
    }

    /**
     * 设置用户角色
     *
     * @return
     */
    @PutMapping("/updateUserRole")
    @ResponseBody
    public BitResult updateUserRole(@RequestBody List<UserRole> userRoleList) {
        try {
            securityService.updateUserRole(userRoleList);
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("设置用户角色失败！");
        }
        return BitResult.success("设置用户角色成功！");
    }

    /**
     * 新增用户角色
     *
     * @return
     */
    @PostMapping("/insertRole")
    @ResponseBody
    public BitResult insertRole(@RequestBody List<RoleInfo> roleInfoList) {
        try {
            securityService.insertRole(roleInfoList);
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("新增用户角色失败！");
        }
        return BitResult.success("新增用户角色成功！");
    }

    /**
     * 删除用户
     *
     * @return
     */
    @DeleteMapping("/deleteUser")
    @ResponseBody
    public BitResult deleteUser(@RequestParam("ids") List<String> ids) {
        try {
            securityService.deleteUser(ids);
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("删除用户失败！");
        }
        return BitResult.success("删除用户成功！");
    }

    /**
     * 更新用户信息
     * @param userInfo
     * @return
     */
    @PutMapping("/updateUser")
    @ResponseBody
    public BitResult updateUser(@RequestBody UserInfo userInfo) {
        try {
            securityService.updateUser(userInfo);
        } catch (Exception e) {
            e.printStackTrace();
            return BitResult.failure("更新用户信息失败！");
        }
        return BitResult.success("更新用户信息成功！");
    }

}
