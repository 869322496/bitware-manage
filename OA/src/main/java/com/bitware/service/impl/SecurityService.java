package com.bitware.service.impl;

import com.bitware.bean.LeaveInfo;
import com.bitware.bean.ResourceInfo;
import com.bitware.bean.RoleInfo;
import com.bitware.bean.UserInfo;

import java.util.List;


public interface SecurityService {

    UserInfo getUserInfoByUserAccount(String userAccount);

    List<RoleInfo> getRoleList();

    void insertRoleResource(String roleId, String category, List<String> resourceIds);

    List<ResourceInfo> getMenuByRoleId(String roleId);

    List<ResourceInfo> getResourceByRoleId(String roleId, String category, String code);
}
