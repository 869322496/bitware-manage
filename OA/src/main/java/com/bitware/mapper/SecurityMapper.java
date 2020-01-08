package com.bitware.mapper;

import com.bitware.bean.ResourceInfo;
import com.bitware.bean.RoleInfo;
import com.bitware.bean.UserInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface  SecurityMapper {

    UserInfo getUserInfoByUserAccount(@Param("userAccount") String userAccount);

    List<RoleInfo> getRoleList();

    List<ResourceInfo> getResourceByRoleId(@Param("roleId") String roleId, @Param("category") String category, @Param("code") String code);

    void insertRoleResource(@Param("roleId") String roleId,  @Param("resourceIds") List<String> resourceIds);

    void deleteRoleResource(@Param("roleId") String roleId, @Param("resourceIds") List<String> resourceIds);
}
