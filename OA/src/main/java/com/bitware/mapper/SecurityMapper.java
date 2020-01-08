package com.bitware.mapper;

import com.bitware.bean.RoleInfo;
import com.bitware.bean.UserInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface  SecurityMapper {

    UserInfo getUserInfoByUserAccount(@Param("userAccount") String userAccount);

    List<RoleInfo> getRoleList();
}
