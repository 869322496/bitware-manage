package com.bitware.service.impl;

import com.bitware.bean.LeaveInfo;
import com.bitware.bean.ResourceInfo;
import com.bitware.bean.RoleInfo;
import com.bitware.bean.UserInfo;
import com.bitware.mapper.SecurityMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class SecurityServiceImpl implements SecurityService {
    @Autowired
    SecurityMapper securityMapper;

    @Override
    public UserInfo getUserInfoByUserAccount(String userAccount) {
        return securityMapper.getUserInfoByUserAccount(userAccount);
    }

    @Override
    public List<RoleInfo> getRoleList() {
        return securityMapper.getRoleList();
    }

    @Override
    @Transactional
    public void insertRoleResource(String roleId, String category, List<String> resourceIds) {
        List<String> deleteIds = securityMapper.getResourceByRoleId(roleId, category, null)
                .stream()
                .map(ResourceInfo::getId)
                .collect(Collectors.toList());
        if (deleteIds.size() > 0) securityMapper.deleteRoleResource(roleId, deleteIds);
        if (resourceIds.size() > 0) securityMapper.insertRoleResource(roleId, resourceIds);
    }

    @Override
    public List<ResourceInfo> getMenuByRoleId(String roleId) {
        return securityMapper.getResourceByRoleId(roleId, null, null);
    }

    @Override
    public List<ResourceInfo> getResourceByRoleId(String roleId, String category, String code) {
        return securityMapper.getResourceByRoleId(roleId, category, code);
    }
}
