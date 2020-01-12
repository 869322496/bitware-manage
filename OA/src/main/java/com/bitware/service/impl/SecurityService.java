package com.bitware.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.bitware.bean.*;

import java.util.List;


public interface SecurityService {

    List<UserInfo> getUserInfoByUserAccount(String userAccount);

    List<RoleInfo> getRoleList();

    void insertRoleResource(String roleId, String category, List<String> resourceIds);

    List<ResourceInfo> getMenuByRoleId(String roleId);

    List<ResourceInfo> getResourceByRoleId(String roleId, String category, String code);

    void insertUser(UserInfo userInfo);

    void updateUserRole(List<UserRole> userRoleList);


    void insertRole(List<RoleInfo> roleInfoList);
}
